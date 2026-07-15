#!/usr/bin/env python3
"""Extract tracked changes and comments from proofed DOCX files."""

from __future__ import annotations

import argparse
import json
import re
import sys
import zipfile
from collections import Counter, defaultdict
from pathlib import Path
from xml.etree import ElementTree as ET


W_NS = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"
W = f"{{{W_NS}}}"
TEXT_TAGS = {f"{W}t", f"{W}delText", f"{W}instrText", f"{W}delInstrText"}
REVISION_TAGS = ("ins", "del", "moveFrom", "moveTo")
FORMATTING_REVISION_TAGS = (
    "rPrChange",
    "pPrChange",
    "tblPrChange",
    "tblGridChange",
    "tcPrChange",
    "trPrChange",
    "sectPrChange",
)


def attr(element: ET.Element, name: str, default: str = "") -> str:
    return element.attrib.get(f"{W}{name}", default)


def normalized(text: str) -> str:
    return re.sub(r"\s+", " ", text).strip()


def is_visible(tag: str, mode: str, visible: bool) -> bool:
    if not visible:
        return False
    if mode == "original" and tag in {f"{W}ins", f"{W}moveTo"}:
        return False
    if mode == "revised" and tag in {f"{W}del", f"{W}moveFrom"}:
        return False
    return True


def render_text(element: ET.Element, mode: str) -> str:
    pieces: list[str] = []

    def walk(node: ET.Element, visible: bool = True) -> None:
        visible = is_visible(node.tag, mode, visible)
        if visible and node.tag in TEXT_TAGS and node.text:
            pieces.append(node.text)
        elif visible and node.tag == f"{W}tab":
            pieces.append("\t")
        elif visible and node.tag in {f"{W}br", f"{W}cr"}:
            pieces.append("\n")
        elif visible and node.tag == f"{W}noBreakHyphen":
            pieces.append("‑")
        elif visible and node.tag == f"{W}softHyphen":
            pieces.append("\u00ad")
        for child in node:
            walk(child, visible)

    walk(element)
    return normalized("".join(pieces))


def tracked_revision_chunks(paragraph: ET.Element) -> list[dict[str, str]]:
    """Return Word's revision units without quadratic text realignment."""
    parent = {child: node for node in paragraph.iter() for child in node}
    revision_names = {f"{W}{tag}": tag for tag in REVISION_TAGS}
    chunks: list[dict[str, str]] = []
    for element in paragraph.iter():
        kind = revision_names.get(element.tag)
        if kind is None:
            continue
        ancestor = parent.get(element)
        nested = False
        while ancestor is not None and ancestor is not paragraph:
            if ancestor.tag in revision_names:
                nested = True
                break
            ancestor = parent.get(ancestor)
        if nested:
            continue
        chunks.append(
            {
                "operation": kind,
                "original": render_text(element, "original"),
                "revised": render_text(element, "revised"),
                "author": attr(element, "author"),
                "date": attr(element, "date"),
            }
        )
    return chunks


def paragraph_style(paragraph: ET.Element) -> str:
    style = paragraph.find(f"{W}pPr/{W}pStyle")
    return attr(style, "val") if style is not None else ""


def paragraph_locations(
    root: ET.Element, paragraphs: list[ET.Element]
) -> dict[int, str]:
    parent = {child: node for node in root.iter() for child in node}
    locations: dict[int, str] = {}
    for index, paragraph in enumerate(paragraphs, start=1):
        node = paragraph
        location = "body"
        while node in parent:
            node = parent[node]
            if node.tag == f"{W}tc":
                location = "table"
                break
            if node.tag in {f"{W}txbxContent", f"{W}textbox"}:
                location = "text-box"
                break
        locations[index] = location
    return locations


def collect_comment_anchors(
    root: ET.Element, paragraphs: list[ET.Element], mode: str
) -> tuple[dict[str, str], dict[str, list[int]]]:
    active: set[str] = set()
    pieces: defaultdict[str, list[str]] = defaultdict(list)
    indices: defaultdict[str, set[int]] = defaultdict(set)
    paragraph_numbers = {
        id(paragraph): index
        for index, paragraph in enumerate(paragraphs, 1)
    }

    def walk(
        node: ET.Element,
        visible: bool = True,
        paragraph_number: int | None = None,
    ) -> None:
        if node.tag == f"{W}p":
            paragraph_number = paragraph_numbers[id(node)]
        visible = is_visible(node.tag, mode, visible)
        if visible and node.tag == f"{W}commentRangeStart":
            comment_id = attr(node, "id")
            if comment_id:
                active.add(comment_id)
                if paragraph_number is not None:
                    indices[comment_id].add(paragraph_number)
        elif visible and node.tag == f"{W}commentRangeEnd":
            comment_id = attr(node, "id")
            if comment_id and paragraph_number is not None:
                indices[comment_id].add(paragraph_number)
            active.discard(comment_id)
        elif visible and node.tag in TEXT_TAGS and node.text:
            for comment_id in active:
                pieces[comment_id].append(node.text)
                if paragraph_number is not None:
                    indices[comment_id].add(paragraph_number)
        elif visible and node.tag == f"{W}tab":
            for comment_id in active:
                pieces[comment_id].append("\t")
        elif visible and node.tag in {f"{W}br", f"{W}cr"}:
            for comment_id in active:
                pieces[comment_id].append("\n")
        for child in node:
            walk(child, visible, paragraph_number)

    walk(root)
    return (
        {
            comment_id: normalized("".join(text))
            for comment_id, text in pieces.items()
        },
        {comment_id: sorted(values) for comment_id, values in indices.items()},
    )


def read_comments(
    archive: zipfile.ZipFile,
    original_anchors: dict[str, str],
    revised_anchors: dict[str, str],
    anchor_indices: dict[str, list[int]],
) -> list[dict[str, object]]:
    try:
        comments_root = ET.fromstring(archive.read("word/comments.xml"))
    except KeyError:
        return []
    comments: list[dict[str, object]] = []
    for comment in comments_root.findall(f"{W}comment"):
        comment_id = attr(comment, "id")
        comments.append(
            {
                "id": comment_id,
                "author": attr(comment, "author"),
                "initials": attr(comment, "initials"),
                "date": attr(comment, "date"),
                "paragraphs": anchor_indices.get(comment_id, []),
                "anchor_original": original_anchors.get(comment_id, ""),
                "anchor_revised": revised_anchors.get(comment_id, ""),
                "text": render_text(comment, "revised"),
            }
        )
    return comments


def revision_summary(
    root: ET.Element,
) -> tuple[dict[str, int], list[dict[str, object]]]:
    counts = {
        tag: sum(1 for _ in root.iter(f"{W}{tag}"))
        for tag in REVISION_TAGS + FORMATTING_REVISION_TAGS
    }
    by_editor: Counter[tuple[str, str]] = Counter()
    for tag in REVISION_TAGS:
        for element in root.iter(f"{W}{tag}"):
            by_editor[(attr(element, "author") or "(unknown)", tag)] += 1
    editors: list[dict[str, object]] = []
    for author in sorted({author for author, _ in by_editor}):
        editors.append(
            {
                "author": author,
                "revisions": {
                    tag: by_editor[(author, tag)]
                    for tag in REVISION_TAGS
                    if by_editor[(author, tag)]
                },
            }
        )
    return counts, editors


def extract_feedback(path: str | Path) -> dict[str, object]:
    docx_path = Path(path)
    with zipfile.ZipFile(docx_path) as archive:
        try:
            root = ET.fromstring(archive.read("word/document.xml"))
        except KeyError as error:
            message = f"{docx_path} has no word/document.xml"
            raise ValueError(message) from error

        paragraphs = list(root.iter(f"{W}p"))
        locations = paragraph_locations(root, paragraphs)
        original_anchors, original_indices = collect_comment_anchors(
            root, paragraphs, "original"
        )
        revised_anchors, revised_indices = collect_comment_anchors(
            root, paragraphs, "revised"
        )
        anchor_indices = {
            comment_id: sorted(
                set(original_indices.get(comment_id, []))
                | set(revised_indices.get(comment_id, []))
            )
            for comment_id in set(original_indices) | set(revised_indices)
        }
        comments = read_comments(
            archive, original_anchors, revised_anchors, anchor_indices
        )

    changes: list[dict[str, object]] = []
    current_section = ""
    for index, paragraph in enumerate(paragraphs, start=1):
        original = render_text(paragraph, "original")
        revised = render_text(paragraph, "revised")
        style = paragraph_style(paragraph)
        if "heading" in style.casefold() and revised:
            current_section = revised
        if original != revised:
            changes.append(
                {
                    "paragraph": index,
                    "section": current_section,
                    "style": style,
                    "location": locations[index],
                    "original": original,
                    "revised": revised,
                    "diff": tracked_revision_chunks(paragraph),
                }
            )

    revision_counts, editors = revision_summary(root)
    return {
        "file": str(docx_path),
        "summary": {
            "paragraphs": len(paragraphs),
            "changed_paragraphs": len(changes),
            "comments": len(comments),
            "text_revisions": sum(
                revision_counts[tag] for tag in REVISION_TAGS
            ),
            "formatting_revisions": sum(
                revision_counts[tag] for tag in FORMATTING_REVISION_TAGS
            ),
            "revision_elements": revision_counts,
        },
        "editors": editors,
        "comments": comments,
        "changes": changes,
    }


def markdown_escape(text: object) -> str:
    return str(text).replace("\\", "\\\\").replace("`", "\\`")


def render_markdown(reports: list[dict[str, object]], max_changes: int) -> str:
    lines = ["# DOCX editor-feedback extraction", ""]
    for report in reports:
        summary = report["summary"]
        assert isinstance(summary, dict)
        lines.extend(
            [
                f"## {Path(str(report['file'])).name}",
                "",
                f"- Paragraphs: {summary['paragraphs']}",
                f"- Changed paragraphs: {summary['changed_paragraphs']}",
                f"- Comments: {summary['comments']}",
                f"- Text revision elements: {summary['text_revisions']}",
                "- Formatting revision elements: "
                f"{summary['formatting_revisions']}",
                "",
                "### Comments",
                "",
            ]
        )
        comments = report["comments"]
        assert isinstance(comments, list)
        if not comments:
            lines.extend(["None.", ""])
        for comment in comments:
            assert isinstance(comment, dict)
            lines.extend(
                [
                    f"- Comment {comment['id']} by "
                    f"{markdown_escape(comment['author'])}",
                    f"  - Paragraphs: {comment['paragraphs']}",
                    "  - Original anchor: "
                    f"`{markdown_escape(comment['anchor_original'])}`",
                    "  - Revised anchor: "
                    f"`{markdown_escape(comment['anchor_revised'])}`",
                    f"  - Feedback: {markdown_escape(comment['text'])}",
                ]
            )
        lines.extend(["", "### Tracked text changes", ""])
        changes = report["changes"]
        assert isinstance(changes, list)
        selected = changes if max_changes == 0 else changes[:max_changes]
        for change in selected:
            assert isinstance(change, dict)
            descriptor = f"paragraph {change['paragraph']}"
            if change["section"]:
                section = markdown_escape(change["section"])
                descriptor += f"; section: {section}"
            descriptor += f"; {change['location']}"
            lines.extend(
                [
                    f"#### {descriptor}",
                    "",
                    f"- Original: {markdown_escape(change['original'])}",
                    f"- Revised: {markdown_escape(change['revised'])}",
                    "- Diff chunks:",
                ]
            )
            diff = change["diff"]
            assert isinstance(diff, list)
            for chunk in diff:
                lines.append(
                    "  - "
                    f"{chunk['operation']}: "
                    f"`{markdown_escape(chunk['original'])}` → "
                    f"`{markdown_escape(chunk['revised'])}`"
                )
            lines.append("")
        if max_changes and len(changes) > max_changes:
            lines.extend(
                [
                    f"_Showing {max_changes} of {len(changes)} "
                    "changed paragraphs._",
                    "",
                ]
            )
    return "\n".join(lines)


def parse_args(argv: list[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Extract original/revised paragraph pairs and anchored "
            "comments from "
            "tracked-change DOCX files."
        )
    )
    parser.add_argument("docx", nargs="+", type=Path)
    parser.add_argument(
        "--format",
        choices=("json", "markdown"),
        default="markdown",
    )
    parser.add_argument("--output", type=Path)
    parser.add_argument(
        "--max-changes",
        type=int,
        default=0,
        help=(
            "Limit changed paragraphs per document in Markdown "
            "(0 means all)."
        ),
    )
    return parser.parse_args(argv)


def main(argv: list[str] | None = None) -> int:
    args = parse_args(argv)
    if args.max_changes < 0:
        raise SystemExit("--max-changes must be 0 or greater")
    try:
        reports = [extract_feedback(path) for path in args.docx]
    except (OSError, ET.ParseError, zipfile.BadZipFile, ValueError) as error:
        print(f"error: {error}", file=sys.stderr)
        return 1
    if args.format == "json":
        output = json.dumps(
            {"schema_version": 1, "documents": reports},
            ensure_ascii=False,
            indent=2,
        )
    else:
        output = render_markdown(reports, args.max_changes)
    if args.output:
        args.output.write_text(output + "\n", encoding="utf-8")
    else:
        print(output)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

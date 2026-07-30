#!/usr/bin/env python3
"""Advisory scan for cumulative or overly broad manuscript downgrading."""

from __future__ import annotations

import argparse
import bisect
import json
import re
import sys
from pathlib import Path
from typing import Any


SECTION_NAMES = {
    "abstract": "abstract",
    "introduction": "introduction",
    "methods": "methods",
    "method": "methods",
    "results": "results",
    "results and discussion": "discussion",
    "discussion": "discussion",
    "general discussion": "discussion",
    "limitations": "limitations",
    "limitations and future directions": "limitations",
    "strengths and limitations": "limitations",
    "conclusion": "conclusion",
    "conclusions": "conclusion",
    "cover letter": "cover_letter",
    "title": "title",
}

GLOBAL_VERDICT_PATTERNS = (
    (
        "preliminary-promising",
        re.compile(
            r"\bpreliminary\s+but\s+promising\b",
            re.IGNORECASE,
        ),
    ),
    (
        "partial-psychometric-support",
        re.compile(
            r"\bpartial\s+psychometric\s+support\b",
            re.IGNORECASE,
        ),
    ),
    (
        "initial-validation",
        re.compile(r"\binitial\s+validation\b", re.IGNORECASE),
    ),
    (
        "validation-incomplete",
        re.compile(
            r"\b(?:incomplete|unfinished)\s+validation\b"
            r"|\bvalidation\s+(?:is\s+)?(?:incomplete|unfinished)\b"
            r"|\bcompletion\s+of\s+the\s+validation\s+process\b",
            re.IGNORECASE,
        ),
    ),
    (
        "weak-evidence",
        re.compile(
            r"\bevidence\s+(?:is|was|remains?)\s+"
            r"(?:weak|limited)\b",
            re.IGNORECASE,
        ),
    ),
    (
        "deliberately-conservative",
        re.compile(
            r"\bdeliberately\s+conservative\b",
            re.IGNORECASE,
        ),
    ),
)

BROAD_CLAIM_PATTERNS = (
    re.compile(
        r"\b(?:the\s+)?(?:fi|\uFB01)nd(?:ings|-\s*ings)\b"
        r"[^.!?]{0,180}?"
        r"\b(?:partial|weak|limited|preliminary|generaliz\w*)\b",
        re.IGNORECASE | re.DOTALL,
    ),
    re.compile(
        r"\bevidence\s+(?:is|was|remains?)\s+(?:weak|limited)\b",
        re.IGNORECASE,
    ),
)

EDITORIAL_SECTIONS = (
    "abstract",
    "discussion",
    "limitations",
    "conclusion",
    "cover_letter",
)


def _normalize_heading(text: str) -> str | None:
    heading = re.sub(
        r"^\s*\d+(?:\.\d+)*\.?\s+",
        "",
        text.strip(),
    )
    heading = heading.rstrip(":").strip().lower()
    return SECTION_NAMES.get(heading)


def _section_markers(text: str) -> list[tuple[int, str]]:
    markers: list[tuple[int, str]] = [(0, "other")]
    offset = 0
    first_markdown_heading = True

    for line in text.splitlines(keepends=True):
        stripped = line.strip()
        markdown = re.match(r"^(#{1,6})\s+(.+?)\s*$", stripped)
        if markdown:
            heading_text = markdown.group(2)
            normalized = _normalize_heading(heading_text)
            if normalized is None and first_markdown_heading:
                normalized = "title"
            first_markdown_heading = False
            if normalized is not None:
                markers.append((offset, normalized))
        elif stripped:
            normalized = _normalize_heading(stripped)
            if normalized is not None:
                markers.append((offset, normalized))
        offset += len(line)

    markers.sort(key=lambda marker: marker[0])
    return markers


def _section_at(
    position: int,
    markers: list[tuple[int, str]],
) -> str:
    starts = [marker[0] for marker in markers]
    index = bisect.bisect_right(starts, position) - 1
    return markers[max(index, 0)][1]


def _line_number(text: str, position: int) -> int:
    return text.count("\n", 0, position) + 1


def _excerpt(text: str, start: int, end: int) -> str:
    left = max(0, start - 80)
    right = min(len(text), end + 120)
    excerpt = re.sub(r"\s+", " ", text[left:right]).strip()
    return excerpt


def _finding(
    *,
    code: str,
    message: str,
    section: str,
    phrase: str,
    line: int | None,
    excerpt: str,
) -> dict[str, Any]:
    return {
        "code": code,
        "severity": "review",
        "section": section,
        "line": line,
        "phrase": phrase,
        "message": message,
        "excerpt": excerpt,
    }


def audit_text(text: str, source: str = "<text>") -> dict[str, Any]:
    """Return advisory findings without changing the supplied text."""
    markers = _section_markers(text)
    findings: list[dict[str, Any]] = []
    global_hits: list[tuple[int, str]] = []

    for label, pattern in GLOBAL_VERDICT_PATTERNS:
        for match in pattern.finditer(text):
            section = _section_at(match.start(), markers)
            global_hits.append((match.start(), section))
            findings.append(
                _finding(
                    code="GLOBAL_VERDICT",
                    message=(
                        "Replace a global maturity verdict with "
                        "claim-specific evidence unless the study stage "
                        "itself is the intended, supported claim."
                    ),
                    section=section,
                    phrase=label,
                    line=_line_number(text, match.start()),
                    excerpt=_excerpt(text, match.start(), match.end()),
                )
            )

    seen_broad_spans: set[tuple[int, int]] = set()
    for pattern in BROAD_CLAIM_PATTERNS:
        for match in pattern.finditer(text):
            span = match.span()
            if span in seen_broad_spans:
                continue
            seen_broad_spans.add(span)
            findings.append(
                _finding(
                    code="BROAD_CLAIM_OBJECT",
                    message=(
                        "Name the exact result, measurement property, "
                        "population quantity, or intended use constrained "
                        "by this qualification."
                    ),
                    section=_section_at(match.start(), markers),
                    phrase=re.sub(r"\s+", " ", match.group(0)).strip(),
                    line=_line_number(text, match.start()),
                    excerpt=_excerpt(text, match.start(), match.end()),
                )
            )

    ordered_sections: list[str] = []
    for position, section in sorted(global_hits):
        if (
            section in EDITORIAL_SECTIONS
            and section not in ordered_sections
        ):
            ordered_sections.append(section)

    if len(ordered_sections) >= 2:
        findings.append(
            _finding(
                code="CROSS_SECTION_DOWNGRADE",
                message=(
                    "Review whether repeated global downgrading across "
                    "editorial sections can be consolidated into "
                    "claim-specific qualifications."
                ),
                section="multiple",
                phrase=", ".join(ordered_sections),
                line=None,
                excerpt="",
            )
        )

    abstract_starts = [
        position
        for position, section in markers
        if section == "abstract"
    ]
    title_end = abstract_starts[0] if abstract_starts else min(
        len(text),
        500,
    )
    title_segment = text[:title_end]
    title_claims_validation = bool(
        re.search(r"\bvalidat(?:e|ed|ion)\b", title_segment, re.IGNORECASE)
    )
    maturity_sections = {
        section
        for _, section in global_hits
        if section in {"abstract", "conclusion"}
    }
    if title_claims_validation and maturity_sections:
        findings.append(
            _finding(
                code="TITLE_MATURITY_MISMATCH",
                message=(
                    "Check whether the title presents validation while "
                    "the abstract or conclusion globally recasts the "
                    "study as preliminary or incomplete. Resolve the "
                    "tension with property-specific conclusions."
                ),
                section="title",
                phrase=", ".join(sorted(maturity_sections)),
                line=1,
                excerpt=re.sub(r"\s+", " ", title_segment).strip()[:240],
            )
        )

    return {
        "source": source,
        "summary": {
            "finding_count": len(findings),
            "global_verdict_count": len(global_hits),
            "sections_with_global_verdicts": ordered_sections,
            "advisory_only": True,
        },
        "findings": findings,
    }


def _render_text(report: dict[str, Any]) -> str:
    lines = [
        f"Claim-language audit: {report['source']}",
        (
            "Advisory findings: "
            f"{report['summary']['finding_count']}"
        ),
    ]
    for finding in report["findings"]:
        location = finding["section"]
        if finding["line"] is not None:
            location += f":{finding['line']}"
        lines.append(
            f"- [{finding['code']}] {location}: "
            f"{finding['message']}"
        )
    lines.append(
        "Review findings in context; this tool does not rewrite or "
        "reject manuscript text."
    )
    return "\n".join(lines)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Advisory scan for repeated global verdict language and "
            "overly broad claim objects in manuscript text."
        )
    )
    parser.add_argument(
        "path",
        type=Path,
        help="UTF-8 plain-text or Markdown manuscript.",
    )
    parser.add_argument(
        "--json",
        action="store_true",
        help="Emit a machine-readable JSON report.",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()
    try:
        text = args.path.read_text(encoding="utf-8")
    except (OSError, UnicodeError) as exc:
        print(f"error: could not read {args.path}: {exc}", file=sys.stderr)
        return 2

    report = audit_text(text, source=str(args.path))
    if args.json:
        print(json.dumps(report, ensure_ascii=False, indent=2))
    else:
        print(_render_text(report))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

#!/bin/bash

# =============================================================================
# Markdown to PDF conversion script via HTML/CSS
# =============================================================================
# MarkdownファイルをPandocでHTML化し、Chromiumの印刷機能でPDFに変換します。
# 横長のMarkdown表をCSSで折り返し・列幅調整するため、調査票向けです。
#
# 使用方法:
#   ./scripts/07_md2pdf_html.sh 入力.md [出力.pdf] [オプション]
#
# 例:
#   ./scripts/07_md2pdf_html.sh 1_research_grants/1_okamoto/questionnaire.md
#   ./scripts/07_md2pdf_html.sh 1_research_grants/1_okamoto/questionnaire.md 1_research_grants/1_okamoto/questionnaire.pdf
#   ./scripts/07_md2pdf_html.sh docs/report.md build/pdf/report.pdf --toc --landscape --header-title "配布資料 2 調査票"
#
# オプション:
#   --toc              目次を付ける
#   --number-sections  見出し番号を付ける
#   --landscape        A4横向きで出力する
#   --header-title     ヘッダー中央に表示する文字列
#   --keep-html        中間HTMLを残す
#   --help             ヘルプを表示する
# =============================================================================

set -euo pipefail

show_help() {
  cat <<'EOF'
使用方法:
  ./scripts/07_md2pdf_html.sh 入力.md [出力.pdf] [--toc] [--number-sections] [--landscape] [--header-title タイトル] [--keep-html]

説明:
  MarkdownファイルをHTML/CSS経由でPDFに変換します。
  出力先を省略した場合は build/pdf/<入力ファイル名>.pdf に保存します。
  Markdown中の \newpage と \clearpage は改ページとして扱います。

オプション:
  --toc              目次を付ける
  --number-sections  見出し番号を付ける
  --landscape        A4横向きで出力する
  --header-title     ヘッダー中央に表示する文字列（既定: 配布資料 2 調査票）
  --keep-html        変換に使った中間HTMLを残す
  --help, -h         このヘルプを表示する

例:
  ./scripts/07_md2pdf_html.sh 1_research_grants/1_okamoto/questionnaire.md
  ./scripts/07_md2pdf_html.sh 1_research_grants/1_okamoto/questionnaire.md 1_research_grants/1_okamoto/questionnaire.pdf
  ./scripts/07_md2pdf_html.sh docs/report.md build/pdf/report.pdf --toc --landscape --header-title "配布資料 2 調査票"
EOF
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

INPUT_FILE=""
OUTPUT_FILE=""
TOC=false
NUMBER_SECTIONS=false
LANDSCAPE=false
KEEP_HTML=false
HEADER_TITLE="配布資料 2 調査票"

while [ "$#" -gt 0 ]; do
  arg="$1"
  case "$arg" in
    --toc)
      TOC=true
      shift
      ;;
    --number-sections)
      NUMBER_SECTIONS=true
      shift
      ;;
    --landscape)
      LANDSCAPE=true
      shift
      ;;
    --header-title)
      if [ "$#" -lt 2 ]; then
        echo "--header-title には値を指定してください" >&2
        exit 1
      fi
      HEADER_TITLE="$2"
      shift 2
      ;;
    --keep-html)
      KEEP_HTML=true
      shift
      ;;
    --help|-h)
      show_help
      exit 0
      ;;
    --*)
      echo "不明なオプション: $arg" >&2
      show_help
      exit 1
      ;;
    *)
      if [ -z "$INPUT_FILE" ]; then
        INPUT_FILE="$arg"
      elif [ -z "$OUTPUT_FILE" ]; then
        OUTPUT_FILE="$arg"
      else
        echo "入力ファイルと出力ファイル以外の位置引数は指定できません: $arg" >&2
        show_help
        exit 1
      fi
      shift
      ;;
  esac
done

if [ -z "$INPUT_FILE" ]; then
  show_help
  exit 1
fi

case "$INPUT_FILE" in
  *.md|*.markdown)
    ;;
  *)
    echo "入力ファイルは .md または .markdown を指定してください: $INPUT_FILE" >&2
    exit 1
    ;;
esac

if [ ! -f "$INPUT_FILE" ]; then
  echo "入力ファイルが見つかりません: $INPUT_FILE" >&2
  exit 1
fi

INPUT_DIR="$(cd "$(dirname "$INPUT_FILE")" && pwd)"
INPUT_BASENAME="$(basename "$INPUT_FILE")"
INPUT_ABS="$INPUT_DIR/$INPUT_BASENAME"

if [ -z "$OUTPUT_FILE" ]; then
  OUTPUT_FILE="$PROJECT_ROOT/build/pdf/${INPUT_BASENAME%.*}.pdf"
fi

case "$OUTPUT_FILE" in
  *.pdf)
    ;;
  *)
    echo "出力ファイルは .pdf を指定してください: $OUTPUT_FILE" >&2
    exit 1
    ;;
esac

mkdir -p "$(dirname "$OUTPUT_FILE")"
OUTPUT_DIR="$(cd "$(dirname "$OUTPUT_FILE")" && pwd)"
OUTPUT_ABS="$OUTPUT_DIR/$(basename "$OUTPUT_FILE")"

if ! command -v pandoc >/dev/null 2>&1; then
  echo "pandoc が見つかりません。py-latex 環境を有効化するか、pandoc をインストールしてください。" >&2
  exit 1
fi

BROWSER=""
BROWSER_CANDIDATES=()

if [ -d "${HOME:-}/.cache/ms-playwright" ]; then
  for playwright_chrome in "${HOME:-}"/.cache/ms-playwright/chromium-*/chrome-linux/chrome; do
    if [ -x "$playwright_chrome" ]; then
      BROWSER_CANDIDATES+=("$playwright_chrome")
    fi
  done
fi

BROWSER_CANDIDATES+=(
  /snap/chromium/current/usr/lib/chromium-browser/chrome
  chromium
  chromium-browser
  google-chrome
  google-chrome-stable
)

for candidate in "${BROWSER_CANDIDATES[@]}"; do
  if [ -x "$candidate" ]; then
    BROWSER="$candidate"
    break
  fi
  if command -v "$candidate" >/dev/null 2>&1; then
    BROWSER="$(command -v "$candidate")"
    break
  fi
done

if [ -z "$BROWSER" ]; then
  echo "Chromium/Chrome が見つかりません。chromium などをインストールしてください。" >&2
  exit 1
fi

PAGE_SIZE="A4 portrait"
if [ "$LANDSCAPE" = true ]; then
  PAGE_SIZE="A4 landscape"
fi

TEMP_DIR="$(mktemp -d /tmp/md2pdf-html.XXXXXX)"
PREPROCESSED_MD="$TEMP_DIR/input.md"
STYLE_FILE="$TEMP_DIR/style.html"
HTML_FILE="$TEMP_DIR/${INPUT_BASENAME%.*}.html"
BROWSER_RUNTIME_DIR="$TEMP_DIR/xdg-runtime"
BROWSER_LOG="$TEMP_DIR/browser.log"

cleanup() {
  if [ "$KEEP_HTML" = true ]; then
    echo "中間HTML: $HTML_FILE"
  else
    rm -rf "$TEMP_DIR"
  fi
}
trap cleanup EXIT

python - "$INPUT_ABS" "$PREPROCESSED_MD" <<'PY'
import html
import re
import sys
from pathlib import Path

src = Path(sys.argv[1])
dst = Path(sys.argv[2])

lines = src.read_text(encoding="utf-8").splitlines()
out = []

choice_line = re.compile(r"^回答選択肢：(.+)$")
choice_split = re.compile(r"、(?=\d+\s)")
page_break = re.compile(r"^\s*\\(?:newpage|clearpage)\s*$")
option_line = re.compile(r"^([〇○□])\s+(.+)$")

index = 0
while index < len(lines):
    line = lines[index]

    if page_break.match(line):
        out.append('<div class="page-break"></div>')
        index += 1
        continue

    if line == "回答選択肢：":
        bullet_items = []
        lookahead = index + 1
        while lookahead < len(lines):
            bullet_match = re.match(r"^-\s+(.+)$", lines[lookahead])
            if not bullet_match:
                break
            bullet_items.append(bullet_match.group(1).strip())
            lookahead += 1
        if bullet_items:
            out.append('<div class="answer-choices">')
            out.append('<div class="answer-choices-title">回答選択肢：</div>')
            out.append('<ul>')
            for item in bullet_items:
                out.append(f"<li>{html.escape(item)}</li>")
            out.append('</ul>')
            out.append('</div>')
            index = lookahead
            continue

    match = choice_line.match(line)
    if match:
        choices = [part.strip() for part in choice_split.split(match.group(1)) if part.strip()]
        if len(choices) > 1:
            out.append('<div class="answer-choices">')
            out.append('<div class="answer-choices-title">回答選択肢：</div>')
            out.append('<ol>')
            for choice in choices:
                item = re.sub(r"^\d+\s*", "", choice)
                out.append(f"<li>{html.escape(item)}</li>")
            out.append('</ol>')
            out.append('</div>')
            index += 1
            continue

    if option_line.match(line):
        options = []
        lookahead = index
        while lookahead < len(lines):
            option_match = option_line.match(lines[lookahead])
            if not option_match:
                break
            options.append((option_match.group(1), option_match.group(2).strip()))
            lookahead += 1
        if options:
            out.append('<div class="option-list">')
            for mark, text in options:
                out.append(
                    f'<div class="option-item"><span class="option-mark">{html.escape(mark)}</span> '
                    f'<span class="option-text">{html.escape(text)}</span></div>'
                )
            out.append('</div>')
            index = lookahead
            continue

    out.append(line)
    index += 1

dst.write_text("\n".join(out) + "\n", encoding="utf-8")
PY

cat > "$STYLE_FILE" <<EOF
<style>
@page {
  size: $PAGE_SIZE;
}

* {
  box-sizing: border-box;
}

html {
  color: #111827;
  font-family: "Noto Sans CJK JP", "Noto Sans JP", "Yu Gothic", "Meiryo", sans-serif;
  font-size: 10.5pt;
  line-height: 1.48;
}

body {
  margin: 0 !important;
  max-width: none !important;
  padding: 0 !important;
  width: 100% !important;
}

h1 {
  border-bottom: 2px solid #111827;
  font-size: 18pt;
  line-height: 1.25;
  margin: 0 0 12pt;
  padding-bottom: 4pt;
}

h2 {
  border-bottom: 1px solid #d1d5db;
  font-size: 14pt;
  margin: 18pt 0 8pt;
  padding-bottom: 3pt;
}

h3 {
  font-size: 11.5pt;
  margin: 14pt 0 6pt;
}

p,
ul,
ol {
  margin: 0 0 8pt;
}

li {
  margin: 2pt 0;
}

.answer-choices {
  background: #f9fafb;
  border: 1px solid #d1d5db;
  break-inside: avoid;
  margin: 6pt 0 10pt;
  page-break-inside: avoid;
  padding: 6pt 8pt;
}

.answer-choices-title {
  font-weight: 700;
  margin-bottom: 3pt;
}

.answer-choices ol,
.answer-choices ul {
  margin: 0;
  padding-left: 20pt;
}

.answer-choices li {
  break-inside: avoid;
  margin: 1.5pt 0;
}

.option-list {
  break-inside: avoid;
  margin: 4pt 0 8pt;
  page-break-inside: avoid;
}

.option-item {
  break-inside: avoid;
  display: block;
  line-height: 1.35;
  margin: 1.8pt 0;
}

.option-mark {
  display: inline-block;
  min-width: 1.1em;
}

table {
  box-sizing: border-box;
  border-collapse: collapse;
  display: table !important;
  font-size: 8.7pt;
  line-height: 1.35;
  margin: 8pt auto 12pt;
  max-width: 98% !important;
  table-layout: fixed;
  width: 98% !important;
}

col:first-child {
  width: 56% !important;
}

col:not(:first-child) {
  width: auto !important;
}

thead {
  display: table-header-group;
}

tr {
  break-inside: avoid;
  page-break-inside: avoid;
}

th,
td {
  border: 1px solid #9ca3af;
  overflow-wrap: anywhere;
  padding: 3pt 3.2pt;
  vertical-align: top;
}

th {
  background: #f3f4f6;
  font-weight: 700;
}

th:first-child,
td:first-child {
  text-align: left;
  width: 56%;
}

th:not(:first-child),
td:not(:first-child) {
  text-align: center;
  white-space: nowrap;
}

code {
  font-family: "Noto Sans Mono CJK JP", "Noto Sans Mono", monospace;
  font-size: 0.92em;
}

blockquote {
  border-left: 4px solid #d1d5db;
  color: #374151;
  margin: 8pt 0;
  padding: 2pt 0 2pt 10pt;
}

.page-break {
  break-before: page;
  page-break-before: always;
}

@media print {
  a {
    color: inherit;
    text-decoration: none;
  }
}
</style>
EOF

PANDOC_OPTS=(
  "$PREPROCESSED_MD"
  --from=markdown+pipe_tables+grid_tables+fenced_code_blocks+yaml_metadata_block+raw_html
  --to=html5
  --output="$HTML_FILE"
  --standalone
  --include-in-header="$STYLE_FILE"
  --metadata="pagetitle:${INPUT_BASENAME%.*}"
)

if [ "$TOC" = true ]; then
  PANDOC_OPTS+=(--toc)
fi

if [ "$NUMBER_SECTIONS" = true ]; then
  PANDOC_OPTS+=(--number-sections)
fi

echo "Markdown to PDF 変換を開始します（HTML/CSS経由）"
echo "入力: $INPUT_ABS"
echo "出力: $OUTPUT_ABS"
echo "ブラウザ: $BROWSER"
echo "ページ: $PAGE_SIZE"
echo "ヘッダー: $HEADER_TITLE"

pandoc "${PANDOC_OPTS[@]}"

mkdir -p "$BROWSER_RUNTIME_DIR"
chmod 700 "$BROWSER_RUNTIME_DIR"

if ! XDG_RUNTIME_DIR="$BROWSER_RUNTIME_DIR" python - "$HTML_FILE" "$OUTPUT_ABS" "$BROWSER" "$HEADER_TITLE" "$LANDSCAPE" >"$BROWSER_LOG" 2>&1 <<'PY'
from pathlib import Path
import html
import sys

try:
    from playwright.sync_api import sync_playwright
except ImportError as exc:
    raise SystemExit(
        "playwright が見つかりません。python -m pip install playwright を実行し、"
        "必要に応じて playwright install chromium を実行してください。"
    ) from exc

html_file = Path(sys.argv[1]).resolve()
output_file = Path(sys.argv[2]).resolve()
browser_path = sys.argv[3]
header_title = sys.argv[4]
landscape = sys.argv[5].lower() == "true"

header_template = f"""
<div style="width:100%;font-family:'Noto Sans CJK JP','Noto Sans JP','Yu Gothic','Meiryo',sans-serif;font-size:9pt;color:#374151;text-align:center;">
  {html.escape(header_title)}
</div>
"""

footer_template = """
<div style="width:100%;font-family:'Noto Sans CJK JP','Noto Sans JP','Yu Gothic','Meiryo',sans-serif;font-size:9pt;color:#374151;text-align:center;">
  <span class="pageNumber"></span>
</div>
"""

with sync_playwright() as playwright:
    browser = playwright.chromium.launch(
        executable_path=browser_path,
        headless=True,
        args=[
            "--no-sandbox",
            "--disable-dev-shm-usage",
            "--disable-crash-reporter",
            "--disable-breakpad",
            "--no-first-run",
            "--no-default-browser-check",
        ],
    )
    page = browser.new_page()
    page.goto(html_file.as_uri(), wait_until="load")
    page.pdf(
        path=str(output_file),
        format="A4",
        landscape=landscape,
        print_background=True,
        display_header_footer=True,
        header_template=header_template,
        footer_template=footer_template,
        margin={
            "top": "14mm",
            "right": "8mm",
            "bottom": "12mm",
            "left": "8mm",
        },
    )
    browser.close()
PY
then
  cat "$BROWSER_LOG" >&2
  echo "Playwright/Chromium によるPDF印刷でエラーが発生しました" >&2
  exit 1
fi

echo "変換完了: $OUTPUT_ABS"
if command -v pdfinfo >/dev/null 2>&1; then
  PAGES="$(pdfinfo "$OUTPUT_ABS" 2>/dev/null | awk '/^Pages:/ {print $2}')"
  if [ -n "$PAGES" ]; then
    echo "ページ数: ${PAGES}ページ"
  fi
fi
echo "ファイルサイズ: $(ls -lh "$OUTPUT_ABS" | awk '{print $5}')"

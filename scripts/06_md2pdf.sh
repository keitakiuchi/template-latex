#!/bin/bash

# =============================================================================
# Markdown to PDF conversion script
# =============================================================================
# MarkdownファイルをPandoc + LuaLaTeXでPDFに変換します。
#
# 使用方法:
#   ./scripts/06_md2pdf.sh 入力.md [出力.pdf] [オプション]
#
# 例:
#   ./scripts/06_md2pdf.sh 1_research_grants/1_okamoto/questionnaire.md
#   ./scripts/06_md2pdf.sh docs/report.md build/pdf/report.pdf --toc
#
# オプション:
#   --toc              目次を付ける
#   --number-sections  見出し番号を付ける
#   --help             ヘルプを表示する
# =============================================================================

set -euo pipefail

show_help() {
  cat <<'EOF'
使用方法:
  ./scripts/06_md2pdf.sh 入力.md [出力.pdf] [--toc] [--number-sections]

説明:
  MarkdownファイルをPDFに変換します。
  出力先を省略した場合は build/pdf/<入力ファイル名>.pdf に保存します。

オプション:
  --toc              目次を付ける
  --number-sections  見出し番号を付ける
  --help, -h         このヘルプを表示する

例:
  ./scripts/06_md2pdf.sh 1_research_grants/1_okamoto/questionnaire.md
  ./scripts/06_md2pdf.sh docs/report.md build/pdf/report.pdf --toc
EOF
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

INPUT_FILE=""
OUTPUT_FILE=""
TOC=false
NUMBER_SECTIONS=false

for arg in "$@"; do
  case "$arg" in
    --toc)
      TOC=true
      ;;
    --number-sections)
      NUMBER_SECTIONS=true
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

if [ -z "$OUTPUT_FILE" ]; then
  INPUT_BASENAME="$(basename "$INPUT_FILE")"
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

if [ -z "${TEXLIVE_PATH:-}" ]; then
  if [ -d "/usr/local/texlive/2025/bin/x86_64-linux" ]; then
    export TEXLIVE_PATH="/usr/local/texlive/2025/bin/x86_64-linux"
  elif [ -d "/mnt/d/texlive/2025/bin/x86_64-linux" ]; then
    export TEXLIVE_PATH="/mnt/d/texlive/2025/bin/x86_64-linux"
  elif [ -d "/mnt/e/texlive/2025/bin/x86_64-linux" ]; then
    export TEXLIVE_PATH="/mnt/e/texlive/2025/bin/x86_64-linux"
  fi
fi

if [ -n "${TEXLIVE_PATH:-}" ]; then
  export PATH="$TEXLIVE_PATH:$PATH"
fi

if ! command -v pandoc >/dev/null 2>&1; then
  echo "pandoc が見つかりません。py-latex 環境を有効化してから実行してください。" >&2
  exit 1
fi

if ! command -v lualatex >/dev/null 2>&1; then
  echo "lualatex が見つかりません。TeX Live のパスまたは TEXLIVE_PATH を確認してください。" >&2
  exit 1
fi

mkdir -p "$(dirname "$OUTPUT_FILE")"

export TEXMFVAR="${TEXMFVAR:-/tmp}"
export TEXMFCACHE="${TEXMFCACHE:-/tmp}"

PANDOC_OPTS=(
  "$INPUT_FILE"
  --from=markdown+pipe_tables+grid_tables+fenced_code_blocks+yaml_metadata_block
  --pdf-engine=lualatex
  --output="$OUTPUT_FILE"
  --standalone
  --variable=documentclass:ltjsarticle
  --variable=classoption:a4paper
  --variable=geometry:margin=25mm
)

if [ "$TOC" = true ]; then
  PANDOC_OPTS+=(--toc)
fi

if [ "$NUMBER_SECTIONS" = true ]; then
  PANDOC_OPTS+=(--number-sections)
fi

echo "Markdown to PDF 変換を開始します"
echo "入力: $INPUT_FILE"
echo "出力: $OUTPUT_FILE"
echo "PDFエンジン: $(command -v lualatex)"

if pandoc "${PANDOC_OPTS[@]}"; then
  echo "変換完了: $OUTPUT_FILE"
  if command -v pdfinfo >/dev/null 2>&1; then
    PAGES="$(pdfinfo "$OUTPUT_FILE" 2>/dev/null | awk '/^Pages:/ {print $2}')"
    if [ -n "$PAGES" ]; then
      echo "ページ数: ${PAGES}ページ"
    fi
  fi
  echo "ファイルサイズ: $(ls -lh "$OUTPUT_FILE" | awk '{print $5}')"
else
  echo "Pandoc変換でエラーが発生しました" >&2
  exit 1
fi

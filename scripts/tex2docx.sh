#!/bin/bash

# 使い方: ./scripts/tex2docx.sh tex/ファイル名.tex

set -e

if [ $# -ne 1 ]; then
  echo "使い方: $0 tex/ファイル名.tex"
  exit 1
fi

TEXFILE="$1"
BASENAME=$(basename "$TEXFILE" .tex)
OUTDIR="../build/docx"
OUTFILE="$OUTDIR/$BASENAME.docx"

# texディレクトリに移動
cd tex

# build/docxディレクトリがなければ作成
mkdir -p "$OUTDIR"

# pandocで変換（texディレクトリから実行）
pandoc "$BASENAME.tex" \
  -o "$OUTFILE" \
  --from=latex \
  --to=docx \
  --wrap=none \
  --standalone \
  --verbose

if [ $? -eq 0 ]; then
  echo "✅ 変換成功: $OUTFILE"
  echo "📄 ファイルサイズ: $(ls -lh "$OUTFILE" | awk '{print $5}')"
else
  echo "❌ 変換失敗"
  exit 1
fi 
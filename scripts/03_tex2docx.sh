#!/bin/bash
# tex2docx_with_bibliography.sh
# LaTeX→DOCX 変換（参考文献リスト確実版）

set -euo pipefail

# ---------- 引数チェック ----------
if [ $# -ne 1 ]; then
  echo "使い方: $0 tex/ファイル名.tex"
  exit 1
fi

TEXFILE="$1"
BASENAME=$(basename "$TEXFILE" .tex)
TEXDIR=$(dirname "$TEXFILE")
OUTDIR="../build/docx"
OUTFILE="$OUTDIR/$BASENAME.docx"

# ---------- 準備 ----------
cd "$TEXDIR"
mkdir -p "$OUTDIR"

# ---------- Step 1: LaTeX+BibTeXでBBLファイルを生成 ----------
echo "📝 LaTeX+BibTeXで参考文献リストを生成中..."

# 1回目のLaTeXコンパイル（.auxファイル生成）
if ! lualatex -interaction=nonstopmode "$BASENAME.tex" > /dev/null 2>&1; then
  echo "⚠️ LaTeXコンパイルに警告がありますが続行します"
fi

# BibTeX実行（.bblファイル生成）
if [ -f "$BASENAME.aux" ]; then
  # .bibファイルの場所を特定
  BIB_CANDIDATES=$(grep -Eo '\\(bibliography|addbibresource)\{[^}]+\}' "$BASENAME.tex" 2>/dev/null \
                     | sed -E 's/.*\{([^}]*)\}.*/\1/' \
                     | tr ',' '\n' \
                     | sed 's/\.bib$//' || true)
  
  BIBFILE=""
  search_paths=( "" "bib/" "../" "../bib/" "../../bib/" )
  
  for bib in $BIB_CANDIDATES; do
    for path in "${search_paths[@]}"; do
      if [ -f "${path}${bib}.bib" ]; then
        BIBFILE="${path}${bib}.bib"
        echo "📚 BibTeX用.bibファイル: $BIBFILE"
        break 2
      fi
    done
  done
  
  # BibTeX実行
  if [ -n "$BIBFILE" ]; then
    if ! bibtex "$BASENAME" > /dev/null 2>&1; then
      echo "⚠️ BibTeX実行に警告がありますが続行します"
    fi
  else
    echo "⚠️ .bibファイルが見つからないため、BibTeXをスキップします"
  fi
fi

# 2回目のLaTeXコンパイル（参考文献を含める）
if [ -f "$BASENAME.bbl" ]; then
  lualatex -interaction=nonstopmode "$BASENAME.tex" > /dev/null 2>&1
fi

# ---------- Step 2: BBLファイルを組み込んだTeXファイルを作成 ----------
if [ -f "$BASENAME.bbl" ]; then
  echo "✅ .bblファイルが見つかりました"
  
  # 一時ファイル作成
  TEMP_TEX="${BASENAME}_temp.tex"
  
  # TeXファイルを処理して、\bibliography{}の前に.bblの内容を挿入
  echo "🔍 \bibliography{}行を検索中..."
  if awk -v bbl="$BASENAME.bbl" '
    /\\bibliography\{/ {
      print "Found bibliography line: " $0 > "/dev/stderr"
      # .bblファイルの内容を挿入
      while ((getline line < bbl) > 0) {
        print line
      }
      close(bbl)
      # \bibliography{}行をコメントアウト
      print "% " $0
      next
    }
    # それ以外の行はそのまま出力
    { print }
  ' "$BASENAME.tex" > "$TEMP_TEX"; then
    echo "✅ 一時ファイル作成完了: $TEMP_TEX"
    # 変換対象を一時ファイルに変更
    CONVERT_FILE="$TEMP_TEX"
  else
    echo "⚠️ 一時ファイル作成に失敗しました"
    CONVERT_FILE="$BASENAME.tex"
  fi
else
  echo "⚠️ .bblファイルが見つかりません"
  CONVERT_FILE="$BASENAME.tex"
fi

# ---------- Step 3: .bib検出（pandoc用） ----------
# BIBFILEは既にStep 1で設定済み
echo "🔍 変換対象ファイル: $CONVERT_FILE"
echo "🔍 .bibファイル: $BIBFILE"

# ---------- Step 4: CSLスタイル検出 ----------
echo "🔍 参考文献スタイルを検索中..."
BST=$(grep -Eo '\\bibliographystyle\{[^}]+\}' "$BASENAME.tex" 2>/dev/null \
        | head -n1 | sed -E 's/\\bibliographystyle\{([^}]+)\}/\1/' \
        | tr '[:upper:]' '[:lower:]' || echo "")
echo "🔍 検出されたスタイル: $BST"

declare -A CSL_MAP=(
  [ieeetr]="ieee.csl"
  [ieeetran]="ieee.csl"
  [ieee]="ieee.csl"
  [apa]="apa.csl"
  [apalike]="apa.csl"
  [acm]="acm-sig-proceedings.csl"
  [vancouver]="vancouver.csl"
  [plain]="ieee.csl"  # デフォルト
)

CSL_OPTION=""
if [[ -n "$BST" && -n "${CSL_MAP[$BST]+_}" ]]; then
  CSL_FILE="csl/${CSL_MAP[$BST]}"
  if [[ ! -f "$CSL_FILE" ]]; then
    echo "🌐 CSLファイルを自動取得: $CSL_FILE"
    mkdir -p "$(dirname "$CSL_FILE")"
    curl -sL -o "$CSL_FILE" \
      "https://raw.githubusercontent.com/citation-style-language/styles/master/${CSL_MAP[$BST]}" || true
  fi
  [[ -f "$CSL_FILE" ]] && CSL_OPTION="--csl=$CSL_FILE"
fi

# ---------- Step 5: Pandoc変換 ----------
echo "🔄 Pandocで変換中..."

# 変換オプションを構築
PANDOC_OPTS=(
  "$CONVERT_FILE"
  --from=latex
  --to=docx
  --output="$OUTFILE"
  --wrap=none
  --standalone
)

# .bibファイルがある場合はciteprocを使用
if [ -n "$BIBFILE" ] && [ -f "$BIBFILE" ]; then
  echo "📚 使用する.bib: $BIBFILE"
  PANDOC_OPTS+=(
    --bibliography="$BIBFILE"
    --citeproc
  )
  [ -n "$CSL_OPTION" ] && PANDOC_OPTS+=($CSL_OPTION)
fi

# 実行
if pandoc "${PANDOC_OPTS[@]}" 2>&1 | tee pandoc.log; then
  echo "✅ 変換成功"
else
  echo "❌ Pandoc変換でエラーが発生しました"
  cat pandoc.log
  exit 1
fi

# ---------- クリーンアップ ----------
echo "🧹 一時ファイルをクリーンアップ中..."

# 削除前のファイル一覧を表示
echo "📋 削除対象ファイル:"
ls -la *.aux *.log *.bbl *.blg *.out *.toc *.pdf 2>/dev/null | grep -v "No such file" || echo "  削除対象ファイルなし"

# LaTeX関連の一時ファイルを削除
rm -f "$TEMP_TEX" *.aux *.log *.bbl *.blg *.out *.toc *.pdf pandoc.log 2>/dev/null
echo "✅ LaTeX中間ファイルをクリーンアップ完了"

# ---------- 結果確認 ----------
if [ -f "$OUTFILE" ]; then
  echo "✅ 変換完了: $OUTFILE"
  echo "📄 ファイルサイズ: $(ls -lh "$OUTFILE" | awk '{print $5}')"
  
  # 参考文献の存在チェック（オプション）
  if command -v unzip &> /dev/null; then
    if unzip -p "$OUTFILE" word/document.xml 2>/dev/null | grep -q "References\|参考文献\|Bibliography\|\\\\bibitem"; then
      echo "📚 参考文献セクションが含まれています"
    else
      echo "⚠️ 参考文献セクションが見つかりません"
    fi
  fi
else
  echo "❌ 出力ファイルが作成されませんでした"
  exit 1
fi
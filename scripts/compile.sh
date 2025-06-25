#!/bin/bash

# TeX Live のパスを設定
export TL_SSD="/mnt/d"
export PATH="$TL_SSD/texlive/2025/bin/x86_64-linux:$PATH"

# カレントディレクトリを確認
if [ -d "tex" ]; then
  cd tex
  echo "📁 texディレクトリに移動しました"
fi

# ファイル名を引数から取得（デフォルトはJPR_LLM_evaluation）
TEX_FILE=${1:-JPR_LLM_evaluation}
echo "🔄 コンパイル開始: ${TEX_FILE}.tex"

# 必要なディレクトリを作成（プロジェクトルートのみ）
mkdir -p ../build/pdf bib

# LaTeX + BibTeX コンパイル実行
echo "📝 第1段階: LaTeX コンパイル（.auxファイル生成）"
lualatex -interaction=nonstopmode ${TEX_FILE}.tex

echo "📚 BibTeX実行（参考文献処理）"
bibtex ${TEX_FILE}

echo "📝 第2段階: LaTeX コンパイル（引用解決）"
lualatex -interaction=nonstopmode ${TEX_FILE}.tex

echo "📝 第3段階: 最終LaTeX コンパイル（完全な引用解決）"
lualatex -interaction=nonstopmode ${TEX_FILE}.tex

# PDFを最終出力ディレクトリにコピー
if [ -f "${TEX_FILE}.pdf" ]; then
  cp "${TEX_FILE}.pdf" "../build/pdf/"
  echo "📄 PDFを../build/pdf/にコピーしました"
fi

# .bblファイルをbibディレクトリにコピー
if [ -f "${TEX_FILE}.bbl" ]; then
  cp "${TEX_FILE}.bbl" "bib/"
  echo "📋 .bblファイルをbib/にコピーしました"
fi

# 結果確認
if [ -f "../build/pdf/${TEX_FILE}.pdf" ]; then
  echo "✅ コンパイル成功！"
  echo "📄 PDF: ../build/pdf/${TEX_FILE}.pdf"
  echo "📚 .bblファイル: bib/${TEX_FILE}.bbl"
  
  # PDFファイルサイズ表示
  echo "📊 PDFサイズ: $(ls -lh ../build/pdf/${TEX_FILE}.pdf | awk '{print $5}')"
  
  # ページ数表示（pdfinfo が利用可能な場合）
  if command -v pdfinfo &> /dev/null; then
    PAGES=$(pdfinfo "../build/pdf/${TEX_FILE}.pdf" 2>/dev/null | grep "Pages:" | awk '{print $2}')
    if [ ! -z "$PAGES" ]; then
      echo "📖 ページ数: ${PAGES}ページ"
    fi
  fi
  
  # 一時ファイルのクリーンアップ
  echo "🧹 一時ファイルをクリーンアップ中..."
  rm -f *.aux *.log *.blg *.synctex.gz *.bbl *.pdf 2>/dev/null
  echo "✨ クリーンアップ完了！"
else
  echo "❌ コンパイル失敗"
  exit 1
fi 
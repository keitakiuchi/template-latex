#!/bin/bash

# TeX Live のパスを設定（Dドライブ版）
export TL_SSD="/mnt/d"
export PATH="$TL_SSD/texlive/2025/bin/x86_64-linux:$PATH"

# カレントディレクトリを確認
if [ -d "tex" ]; then
  cd tex
  echo "📁 texディレクトリに移動しました"
fi

# ファイル名を引数から取得（デフォルトはexample）
TEX_FILE=${1:-example}
echo "🔄 コンパイル開始: ${TEX_FILE}.tex"

# 必要なディレクトリを作成
echo "📁 ディレクトリ構造を確認・作成中..."
mkdir -p ../build/pdf
mkdir -p bib
mkdir -p temp

# 既存のtempディレクトリをクリーンアップ（オプション）
if [ "$2" = "--clean" ]; then
  echo "🧹 tempディレクトリをクリーンアップ中..."
  rm -rf temp/*
fi

# LaTeX + BibTeX コンパイル実行
echo "📝 第1段階: LaTeX コンパイル（.auxファイル生成）"
if ! lualatex -interaction=nonstopmode -output-directory=temp -include-directory=bib ${TEX_FILE}.tex; then
  echo "❌ 第1段階のLaTeXコンパイルでエラーが発生しました"
  exit 1
fi

echo "📚 BibTeX実行（参考文献処理）"
cd temp
# 参考文献ファイルをtempディレクトリにコピー
cp ../bib/${TEX_FILE}.bib . 2>/dev/null || echo "⚠️  参考文献ファイルが見つかりません"
# BibTeXを実行（BIBINPUTS環境変数で参考文献ディレクトリを指定）
export BIBINPUTS="../bib:"
if ! bibtex ${TEX_FILE}; then
  echo "❌ BibTeX実行でエラーが発生しました"
  cd ..
  exit 1
fi
cd ..

echo "📝 第2段階: LaTeX コンパイル（引用解決）"
if ! lualatex -interaction=nonstopmode -output-directory=temp -include-directory=bib ${TEX_FILE}.tex; then
  echo "❌ 第2段階のLaTeXコンパイルでエラーが発生しました"
  exit 1
fi

echo "📝 第3段階: 最終LaTeX コンパイル（完全な引用解決）"
if ! lualatex -interaction=nonstopmode -output-directory=temp -include-directory=bib ${TEX_FILE}.tex; then
  echo "❌ 第3段階のLaTeXコンパイルでエラーが発生しました"
  exit 1
fi

# 最終成果物の配置
echo "📦 最終成果物を配置中..."

# PDFを最終出力ディレクトリにコピー
if [ -f "temp/${TEX_FILE}.pdf" ]; then
  cp "temp/${TEX_FILE}.pdf" "../build/pdf/"
  echo "✅ PDFを../build/pdf/に配置しました"
else
  echo "❌ PDFファイルが見つかりません"
  exit 1
fi

# .bblファイルをbibディレクトリにコピー
if [ -f "temp/${TEX_FILE}.bbl" ]; then
  cp "temp/${TEX_FILE}.bbl" "bib/"
  echo "✅ .bblファイルをbib/に配置しました"
else
  echo "⚠️  .bblファイルが見つかりません（参考文献がない場合）"
fi

# tempディレクトリのクリーンアップ（オプション）
if [ "$2" = "--clean" ] || [ "$3" = "--clean-temp" ]; then
  echo "🧹 tempディレクトリをクリーンアップ中..."
  # 重要なファイルは保持し、一時的なファイルのみ削除
  rm -f temp/${TEX_FILE}.bib
  rm -f temp/${TEX_FILE}.blg
  echo "✅ 一時ファイルをクリーンアップしました"
fi

# 結果確認
if [ -f "../build/pdf/${TEX_FILE}.pdf" ]; then
  echo ""
  echo "🎉 コンパイル成功！"
  echo "=================================="
  echo "📄 PDF: ../build/pdf/${TEX_FILE}.pdf"
  if [ -f "bib/${TEX_FILE}.bbl" ]; then
    echo "📚 .bblファイル: bib/${TEX_FILE}.bbl"
  fi
  
  # PDFファイルサイズ表示
  echo "📊 PDFサイズ: $(ls -lh ../build/pdf/${TEX_FILE}.pdf | awk '{print $5}')"
  
  # ページ数表示（pdfinfo が利用可能な場合）
  if command -v pdfinfo &> /dev/null; then
    PAGES=$(pdfinfo "../build/pdf/${TEX_FILE}.pdf" 2>/dev/null | grep "Pages:" | awk '{print $2}')
    if [ ! -z "$PAGES" ]; then
      echo "📖 ページ数: ${PAGES}ページ"
    fi
  fi
  
  echo "=================================="
  echo "📁 最終成果物の場所:"
  echo "   - PDF: build/pdf/${TEX_FILE}.pdf"
  echo "   - .bbl: tex/bib/${TEX_FILE}.bbl"
  echo ""
  echo "🧹 中間ファイルはtempディレクトリに保持されています"
  echo "📁 ログファイル: tex/temp/${TEX_FILE}.log"
  echo "📁 .auxファイル: tex/temp/${TEX_FILE}.aux"
  echo "📁 .bblファイル: tex/temp/${TEX_FILE}.bbl"
  echo ""
  echo "✨ コンパイル完了！"
else
  echo "❌ コンパイル失敗"
  exit 1
fi 
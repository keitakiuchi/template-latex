#!/bin/bash

# =============================================================================
# LaTeX Template - コンパイルスクリプト
# =============================================================================
# このスクリプトは、LaTeXファイルをコンパイルしてPDFを生成します。
# 
# 使用方法:
#   ./scripts/02_compile.sh [ファイル名] [オプション]
#   
#   例:
#   ./scripts/02_compile.sh example
#   ./scripts/02_compile.sh example --clean
#   ./scripts/02_compile.sh example --clean --clean-temp
#
# オプション:
#   --clean      : 一時ファイルをクリーンアップしてからコンパイル
#   --clean-temp : コンパイル後に一時ファイルをクリーンアップ
# =============================================================================

show_help() {
  cat <<'EOF'
使用方法:
  ./scripts/02_compile.sh [ファイル名] [--clean] [--clean-temp]

オプション:
  --clean       コンパイル前に temp/ を空にする
  --clean-temp  コンパイル後に temp/ の中間ファイルを削除する
  --help        このヘルプを表示する
EOF
}

# TeX Live のパスを環境変数から設定（設定されていない場合はデフォルト）
if [ -z "$TEXLIVE_PATH" ]; then
    # 一般的なTeX Liveのパスを自動検出
    if [ -d "/usr/local/texlive/2025/bin/x86_64-linux" ]; then
        export TEXLIVE_PATH="/usr/local/texlive/2025/bin/x86_64-linux"
    elif [ -d "/mnt/d/texlive/2025/bin/x86_64-linux" ]; then
        export TEXLIVE_PATH="/mnt/d/texlive/2025/bin/x86_64-linux"
    elif [ -d "/mnt/e/texlive/2025/bin/x86_64-linux" ]; then
        export TEXLIVE_PATH="/mnt/e/texlive/2025/bin/x86_64-linux"
    else
        echo "⚠️  TeX Liveのパスが自動検出できませんでした"
        echo "💡 環境変数TEXLIVE_PATHを設定してください:"
        echo "   export TEXLIVE_PATH=\"/path/to/texlive/bin/x86_64-linux\""
        echo "   または、スクリプト内のTEXLIVE_PATH変数を直接編集してください"
        exit 1
    fi
fi

# TeX Liveのパスを設定
export PATH="$TEXLIVE_PATH:$PATH"
echo "🔧 TeX Liveパス: $TEXLIVE_PATH"

# カレントディレクトリを確認
if [ -d "tex" ]; then
  cd tex
  echo "📁 texディレクトリに移動しました"
fi

# 引数を解析
TEX_FILE="example"
CLEAN_BEFORE=false
CLEAN_AFTER=false
TEX_FILE_SET=false

for arg in "$@"; do
  case "$arg" in
    --clean)
      CLEAN_BEFORE=true
      ;;
    --clean-temp)
      CLEAN_AFTER=true
      ;;
    --help|-h)
      show_help
      exit 0
      ;;
    --*)
      echo "❌ 不明なオプション: $arg"
      show_help
      exit 1
      ;;
    *)
      if [ "$TEX_FILE_SET" = false ]; then
        TEX_FILE="$arg"
        TEX_FILE_SET=true
      else
        echo "❌ ファイル名は1つだけ指定してください: $arg"
        show_help
        exit 1
      fi
      ;;
  esac
done

echo "🔄 コンパイル開始: ${TEX_FILE}.tex"

# 必要なディレクトリを作成
echo "📁 ディレクトリ構造を確認・作成中..."
mkdir -p ../build/pdf
mkdir -p ../build/docx
mkdir -p ../build/csv
mkdir -p bib
mkdir -p temp

# 既存のtempディレクトリをクリーンアップ（オプション）
if [ "$CLEAN_BEFORE" = true ]; then
  echo "🧹 tempディレクトリをクリーンアップ中..."
  rm -rf temp/*
fi

# LaTeX + BibTeX コンパイル実行
echo "📝 LaTeX コンパイル（latexmk使用）"
if ! latexmk -pdf -lualatex -interaction=nonstopmode -output-directory=temp "${TEX_FILE}.tex"; then
  echo "❌ LaTeX コンパイルでエラーが発生しました"
  echo "📋 エラーログ: tex/temp/${TEX_FILE}.log"
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
if [ "$CLEAN_AFTER" = true ]; then
  echo "🧹 tempディレクトリをクリーンアップ中..."
  find temp -mindepth 1 -delete
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
  if [ "$CLEAN_AFTER" = true ]; then
    echo "🧹 中間ファイルはクリーンアップ済みです"
  else
    echo "🧹 中間ファイルはtempディレクトリに保持されています"
    echo "📁 ログファイル: tex/temp/${TEX_FILE}.log"
    echo "📁 .auxファイル: tex/temp/${TEX_FILE}.aux"
    echo "📁 .bblファイル: tex/temp/${TEX_FILE}.bbl"
  fi
  echo ""
  echo "✨ コンパイル完了！"
else
  echo "❌ コンパイル失敗"
  exit 1
fi 

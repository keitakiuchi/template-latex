#!/bin/bash

# TeX Live のパスを設定
export TL_SSD="/mnt/d"
export PATH="$TL_SSD/texlive/2025/bin/x86_64-linux:$PATH"

# カレントディレクトリを確認
if [ -d "tex" ]; then
  cd tex
  echo "📁 texディレクトリに移動しました"
fi

# コンパイル実行
echo "🔄 コンパイル開始..."
latexmk -r ../latexmkrc main.tex

# 結果確認
if [ $? -eq 0 ]; then
  echo "✅ コンパイル成功！"
  echo "📄 PDF: ../build/pdf/main.pdf"
  echo "📁 中間ファイル: ../build/aux/"
  
  # PDFファイルの存在確認
  if [ -f "../build/pdf/main.pdf" ]; then
    echo "📊 PDFサイズ: $(ls -lh ../build/pdf/main.pdf | awk '{print $5}')"
  fi
else
  echo "❌ コンパイル失敗"
  exit 1
fi 
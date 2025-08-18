#!/bin/bash

# LaTeXパッケージ自動インストールスクリプト
# 不足しているパッケージを検出して自動でインストール

# ========================================
# 設定: 対象とするTeXファイルを指定
# ========================================
TARGET_TEX_FILE="example.tex"

set -e  # エラーで停止

# TeX Liveのパスを設定（Dドライブ版）
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"
export PATH="/mnt/d/texlive/2025/bin/x86_64-linux:$PATH"

# tlmgrのパスを確認
if ! command -v tlmgr &> /dev/null; then
    echo "❌ tlmgrが見つかりません。TeX Liveのインストールを確認してください。"
    exit 1
fi
echo "✅ tlmgrのパス: $(which tlmgr)"

echo "=== LaTeXパッケージ自動インストールスクリプト ==="
echo "TeX Live 2025のパスを設定しました"
echo "対象ファイル: $TARGET_TEX_FILE"

# texディレクトリに移動
if [ "$(basename "$PWD")" != "tex" ]; then
    cd tex
fi

echo "=== コンパイルを実行して不足パッケージを検出 ==="

# 一度コンパイルを実行してエラーログを生成
# -interaction=nonstopmodeでエラーでも継続
lualatex -interaction=nonstopmode "$TARGET_TEX_FILE" > /dev/null 2>&1 || true

echo "=== 不足しているパッケージを検出 ==="

# ログファイル名を取得（.texを.logに置換）
log_file="${TARGET_TEX_FILE%.tex}.log"

# 不足している.styファイルを抽出
missing_packages=$(grep "not found" "$log_file" | grep -o "File \`[^']*\.sty'" | sed "s/File \`//" | sed "s/\.sty'//" | sort | uniq)

# フォントエラーも検出
font_errors=$(grep -i "font.*not found\|invalid font\|font.*cannot be found" "$log_file" | head -5)

if [ -z "$missing_packages" ] && [ -z "$font_errors" ]; then
    echo "✅ 不足しているパッケージはありません"
    exit 0
fi

if [ -n "$missing_packages" ]; then
    echo "不足しているパッケージ:"
    echo "$missing_packages"
    echo ""
fi

if [ -n "$font_errors" ]; then
    echo "⚠️  フォント関連のエラーが検出されました:"
    echo "$font_errors"
    echo ""
    echo "フォントの問題を解決するには、以下のいずれかを試してください："
    echo "1. システムフォントのインストール"
    echo "2. LaTeXファイルでのフォント設定の変更"
    echo "3. デフォルトフォントの使用"
    echo ""
fi

if [ -n "$missing_packages" ]; then
    echo "=== パッケージをインストール中 ==="

    # 各パッケージをインストール
    for package in $missing_packages; do
        echo "インストール中: $package"
        
        # まず直接パッケージ名でインストールを試行
        if sudo tlmgr install "$package" 2>/dev/null; then
            echo "  ✅ 直接インストール成功: $package"
        else
            echo "  ⚠️  直接インストール失敗、ファイル検索でパッケージ名を特定中..."
            
            # ファイル検索でパッケージ名を特定
            search_result=$(sudo tlmgr search --global --file "$package.sty" 2>/dev/null | head -1)
            
            if [ -n "$search_result" ] && [[ "$search_result" != *"tlmgr:"* ]]; then
                actual_package=$(echo "$search_result" | awk '{print $1}' | sed 's/://')
                echo "  実際のパッケージ名: $actual_package"
                
                if sudo tlmgr install "$actual_package" 2>/dev/null; then
                    echo "  ✅ ファイル検索によるインストール成功: $actual_package"
                else
                    echo "  ❌ ファイル検索によるインストールも失敗: $actual_package"
                fi
            else
                echo "  ❌ ファイル検索でもパッケージ名が見つかりません: $package"
            fi
        fi
        echo ""
    done
fi

echo "=== インストール完了 ==="
echo "再度コンパイルを試行します..."

# 再度コンパイルを試行
lualatex -interaction=nonstopmode "$TARGET_TEX_FILE" > /dev/null 2>&1 || true

# まだ不足しているパッケージがあるかチェック
remaining_packages=$(grep "not found" "$log_file" | grep -o "File \`[^']*\.sty'" | sed "s/File \`//" | sed "s/\.sty'//" | sort | uniq)

# フォントエラーも再チェック
remaining_font_errors=$(grep -i "font.*not found\|invalid font\|font.*cannot be found" "$log_file" | head -3)

if [ -z "$remaining_packages" ] && [ -z "$remaining_font_errors" ]; then
    echo "✅ すべてのパッケージがインストールされました！"
    echo "コンパイルが成功するはずです。"
else
    if [ -n "$remaining_packages" ]; then
        echo "⚠️  まだ不足しているパッケージがあります:"
        echo "$remaining_packages"
        echo ""
    fi
    
    if [ -n "$remaining_font_errors" ]; then
        echo "⚠️  フォントエラーが残っています:"
        echo "$remaining_font_errors"
        echo ""
    fi
    
    echo "このスクリプトを再実行してください。"
fi

echo ""
echo "=== 完了 ===" 
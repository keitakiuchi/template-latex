#!/bin/bash

# スタートスクリプト - 環境チェックとセットアップ
# 使用方法: ./utility/start.sh

echo "🚀 AI駆動コーディングプロジェクトをスタートします..."
echo ""

# プロジェクトルートに移動
cd "$(dirname "$0")/.."

# 仮想環境の確認とアクティベート
echo "🔧 py-latex環境をアクティベート中..."

# conda環境の存在確認
if conda env list | grep -q "py-latex"; then
    echo "✅ py-latex環境が見つかりました"
    
    # 現在の環境を確認
    if [ "$CONDA_DEFAULT_ENV" = "py-latex" ]; then
        echo "✅ py-latex環境は既にアクティブです"
    else
        echo "🔄 py-latex環境をアクティベートしています..."
        conda activate py-latex
        if [ $? -eq 0 ]; then
            echo "✅ py-latex環境がアクティベートされました"
        else
            echo "❌ 環境のアクティベートに失敗しました"
            echo "💡 手動で以下のコマンドを実行してください:"
            echo "   conda activate py-latex"
            exit 1
        fi
    fi
else
    echo "❌ py-latex環境が見つかりません"
    echo "💡 以下のコマンドで環境を作成してください:"
    echo "   conda create -n py-latex python=3.11"
    exit 1
fi

echo ""

# 環境チェックスクリプトの実行
echo "🔍 環境チェックを実行中..."
python utility/check_env.py

# チェック結果に基づいて次のステップを提案
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 環境チェックが完了しました！"
    echo "📝 次のステップ:"
    echo "  1. LaTeXコンパイルを開始: ./scripts/compile.sh"
    echo "  2. 文書編集: tex/ディレクトリ内のファイルを編集"
    echo "  3. AI駆動開発: Cursor IDEのルールファイルを活用"
    echo ""
    echo "🎉 開発を開始できます！"
    echo ""
    echo "💡 今後のセッションでは、以下のコマンドで仮想環境をアクティベートしてください:"
    echo "   conda activate py-latex"
else
    echo ""
    echo "❌ 環境チェックで問題が見つかりました。"
    echo "📋 上記のエラーを修正してから再度実行してください。"
    exit 1
fi 
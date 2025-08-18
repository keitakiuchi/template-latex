#!/bin/bash

# =============================================================================
# LaTeX Template - クリーンアップスクリプト
# =============================================================================
# このスクリプトは、ビルドディレクトリと一時ファイルをクリーンアップします。
# 
# 使用方法:
#   ./scripts/05_cleanup.sh [オプション]
#   
#   オプション:
#   --all        : すべてのビルドファイルを削除
#   --temp       : 一時ファイルのみ削除
#   --build      : ビルド出力のみ削除
#   --help       : ヘルプを表示
# =============================================================================

# ヘルプ表示
show_help() {
    echo "LaTeX Template - クリーンアップスクリプト"
    echo ""
    echo "使用方法:"
    echo "  ./scripts/05_cleanup.sh [オプション]"
    echo ""
    echo "オプション:"
    echo "  --all        : すべてのビルドファイルを削除"
    echo "  --temp       : 一時ファイルのみ削除"
    echo "  --build      : ビルド出力のみ削除"
    echo "  --help       : このヘルプを表示"
    echo ""
    echo "例:"
    echo "  ./scripts/05_cleanup.sh --all"
    echo "  ./scripts/05_cleanup.sh --temp"
    echo "  ./scripts/05_cleanup.sh --build"
}

# 一時ファイルのクリーンアップ
clean_temp() {
    echo "🧹 一時ファイルをクリーンアップ中..."
    
    if [ -d "tex/temp" ]; then
        rm -rf tex/temp/*
        echo "✅ tex/temp/ をクリーンアップしました"
    else
        echo "⚠️  tex/temp/ ディレクトリが見つかりません"
    fi
}

# ビルド出力のクリーンアップ
clean_build() {
    echo "🧹 ビルド出力をクリーンアップ中..."
    
    if [ -d "build" ]; then
        rm -rf build/*
        echo "✅ build/ ディレクトリをクリーンアップしました"
    else
        echo "⚠️  build/ ディレクトリが見つかりません"
    fi
    
    if [ -d "tex/build" ]; then
        rm -rf tex/build/*
        echo "✅ tex/build/ ディレクトリをクリーンアップしました"
    else
        echo "⚠️  tex/build/ ディレクトリが見つかりません"
    fi
}

# すべてのクリーンアップ
clean_all() {
    echo "🧹 すべてのビルドファイルをクリーンアップ中..."
    
    clean_temp
    clean_build
    
    echo "✅ すべてのクリーンアップが完了しました"
}

# メイン処理
main() {
    case "${1:---help}" in
        --all)
            clean_all
            ;;
        --temp)
            clean_temp
            ;;
        --build)
            clean_build
            ;;
        --help|*)
            show_help
            ;;
    esac
}

# スクリプト実行
main "$@"

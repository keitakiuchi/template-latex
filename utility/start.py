#!/usr/bin/env python3
"""
スタートスクリプト - 環境チェックとセットアップ
使用方法: python utility/start.py
"""

import sys
import os
import subprocess
from pathlib import Path

def activate_conda_environment(env_name="py-latex"):
    """conda環境をアクティベート"""
    print(f"🔧 {env_name}環境をアクティベート中...")
    
    try:
        # conda環境の存在確認
        result = subprocess.run(['conda', 'env', 'list'], capture_output=True, text=True)
        if result.returncode == 0 and env_name in result.stdout:
            print(f"✅ {env_name}環境が見つかりました")
            
            # 現在の環境を確認
            current_env = os.getenv('CONDA_DEFAULT_ENV')
            if current_env == env_name:
                print(f"✅ {env_name}環境は既にアクティブです")
                return True
            else:
                print(f"🔄 {env_name}環境をアクティベートしています...")
                # 注意: このスクリプト内では環境を変更できませんが、
                # ユーザーに手動でアクティベートするよう指示します
                print(f"💡 以下のコマンドを実行してください:")
                print(f"   conda activate {env_name}")
                return False
        else:
            print(f"❌ {env_name}環境が見つかりません")
            print(f"💡 以下のコマンドで環境を作成してください:")
            print(f"   conda create -n {env_name} python=3.11")
            return False
    except FileNotFoundError:
        print("❌ condaがインストールされていません")
        return False

def main():
    """メイン関数"""
    print("🚀 AI駆動コーディングプロジェクトをスタートします...")
    print()
    
    # プロジェクトルートに移動
    project_root = Path(__file__).parent.parent
    os.chdir(project_root)
    
    # utilityディレクトリをパスに追加
    utility_path = project_root / "utility"
    if utility_path not in sys.path:
        sys.path.insert(0, str(utility_path))
    
    try:
        # 仮想環境の確認とアクティベート
        env_activated = activate_conda_environment()
        
        if not env_activated:
            print()
            print("⚠️  仮想環境がアクティブではありません。")
            print("📝 以下のコマンドを実行してから再度「スタート」してください:")
            print("   conda activate py-latex")
            print()
            return
        
        # 環境チェックスクリプトの実行
        print("🔍 環境チェックを実行中...")
        from check_env import main as check_env_main
        check_env_main()
        
        print()
        print("✅ 環境チェックが完了しました！")
        print("📝 次のステップ:")
        print("  1. LaTeXコンパイルを開始: ./scripts/compile.sh")
        print("  2. 文書編集: tex/ディレクトリ内のファイルを編集")
        print("  3. AI駆動開発: Cursor IDEのルールファイルを活用")
        print()
        print("🎉 開発を開始できます！")
        print()
        print("💡 今後のセッションでは、以下のコマンドで仮想環境をアクティベートしてください:")
        print("   conda activate py-latex")
        
    except ImportError as e:
        print(f"❌ 環境チェックスクリプトが見つかりません: {e}")
        print("📋 utility/check_env.py ファイルが存在することを確認してください。")
        sys.exit(1)
    except Exception as e:
        print(f"❌ エラーが発生しました: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main() 
#!/usr/bin/env python3
"""
環境チェックスクリプト

このスクリプトは、AI駆動コーディングプロジェクトの環境が適切に設定されているかを確認します。
"""

import os
import sys
import subprocess
import importlib
from typing import List, Dict, Any
from pathlib import Path


class EnvironmentChecker:
    """環境チェックを行うクラス"""
    
    def __init__(self):
        self.errors = []
        self.warnings = []
        self.success_count = 0
        
    def check_python_version(self) -> bool:
        """Pythonバージョンの確認"""
        print("🐍 Pythonバージョンの確認...")
        
        version = sys.version_info
        if version.major == 3 and version.minor >= 8:
            print(f"✅ Python {version.major}.{version.minor}.{version.micro}")
            self.success_count += 1
            return True
        else:
            error_msg = f"❌ Python 3.8以上が必要です。現在のバージョン: {version.major}.{version.minor}.{version.micro}"
            self.errors.append(error_msg)
            print(error_msg)
            return False
    
    def check_virtual_environment(self) -> bool:
        """仮想環境の確認"""
        print("🔧 仮想環境の確認...")
        
        # conda環境の確認
        conda_env = os.getenv('CONDA_DEFAULT_ENV')
        if conda_env and conda_env != 'base':
            print(f"✅ conda環境がアクティブです: {conda_env}")
            self.success_count += 1
            return True
        
        # venv環境の確認
        if hasattr(sys, 'real_prefix') or (hasattr(sys, 'base_prefix') and sys.base_prefix != sys.prefix):
            env_name = os.path.basename(sys.prefix)
            print(f"✅ 仮想環境がアクティブです: {env_name}")
            self.success_count += 1
            return True
        else:
            warning_msg = "⚠️  仮想環境がアクティブではありません。推奨: conda activate py-latex"
            self.warnings.append(warning_msg)
            print(warning_msg)
            return False
    
    def check_required_packages(self) -> bool:
        """必要なパッケージの確認"""
        print("📦 必要なパッケージの確認...")
        
        required_packages = [
            'requests',
            'pytest',
            'black',
            'flake8',
            'mypy'
        ]
        
        missing_packages = []
        
        for package in required_packages:
            try:
                importlib.import_module(package)
                print(f"✅ {package}")
                self.success_count += 1
            except ImportError:
                missing_packages.append(package)
                print(f"❌ {package} - インストールが必要")
        
        if missing_packages:
            error_msg = f"❌ 以下のパッケージがインストールされていません: {', '.join(missing_packages)}"
            self.errors.append(error_msg)
            print(f"\n💡 インストールコマンド:")
            print(f"pip install {' '.join(missing_packages)}")
            return False
        
        return True
    
    def check_config_files(self) -> bool:
        """設定ファイルの確認"""
        print("⚙️  設定ファイルの確認...")
        
        required_files = [
            'requirements.txt',
            'README.md',
            '.gitignore'
        ]
        
        missing_files = []
        
        for file_path in required_files:
            if Path(file_path).exists():
                print(f"✅ {file_path}")
                self.success_count += 1
            else:
                missing_files.append(file_path)
                print(f"❌ {file_path} - ファイルが見つかりません")
        
        if missing_files:
            warning_msg = f"⚠️  以下のファイルが見つかりません: {', '.join(missing_files)}"
            self.warnings.append(warning_msg)
            return False
        
        return True
    
    def check_environment_variables(self) -> bool:
        """環境変数の確認"""
        print("🔑 環境変数の確認...")
        
        # 機密情報の環境変数は存在チェックのみ
        sensitive_vars = [
            'ANTHROPIC_API_KEY',
            'OPENAI_API_KEY',
            'GEMINI_API_KEY'
        ]
        
        for var in sensitive_vars:
            if os.getenv(var):
                print(f"✅ {var} - 設定済み")
                self.success_count += 1
            else:
                print(f"⚠️  {var} - 未設定（必要に応じて設定してください）")
        
        return True
    
    def check_git_status(self) -> bool:
        """Gitの状態確認"""
        print("📝 Gitの状態確認...")
        
        try:
            result = subprocess.run(['git', 'status'], capture_output=True, text=True)
            if result.returncode == 0:
                print("✅ Gitリポジトリが正常です")
                self.success_count += 1
                return True
            else:
                warning_msg = "⚠️  Gitリポジトリの状態を確認できませんでした"
                self.warnings.append(warning_msg)
                print(warning_msg)
                return False
        except FileNotFoundError:
            warning_msg = "⚠️  Gitがインストールされていません"
            self.warnings.append(warning_msg)
            print(warning_msg)
            return False
    
    def check_directory_structure(self) -> bool:
        """ディレクトリ構造の確認"""
        print("📁 ディレクトリ構造の確認...")
        
        required_dirs = [
            'tex',
            'scripts',
            'utility',
            '.cursor/rules'
        ]
        
        missing_dirs = []
        
        for dir_path in required_dirs:
            if Path(dir_path).exists():
                print(f"✅ {dir_path}/")
                self.success_count += 1
            else:
                missing_dirs.append(dir_path)
                print(f"❌ {dir_path}/ - ディレクトリが見つかりません")
        
        if missing_dirs:
            warning_msg = f"⚠️  以下のディレクトリが見つかりません: {', '.join(missing_dirs)}"
            self.warnings.append(warning_msg)
            return False
        
        return True
    
    def run_all_checks(self) -> bool:
        """すべてのチェックを実行"""
        print("🔍 AI駆動コーディング環境チェックを開始します...\n")
        
        checks = [
            self.check_python_version,
            self.check_virtual_environment,
            self.check_required_packages,
            self.check_config_files,
            self.check_environment_variables,
            self.check_git_status,
            self.check_directory_structure
        ]
        
        for check in checks:
            check()
            print()
        
        return self.print_summary()
    
    def print_summary(self) -> bool:
        """チェック結果のサマリーを表示"""
        print("=" * 50)
        print("📊 チェック結果サマリー")
        print("=" * 50)
        
        print(f"✅ 成功: {self.success_count}項目")
        print(f"⚠️  警告: {len(self.warnings)}項目")
        print(f"❌ エラー: {len(self.errors)}項目")
        
        if self.warnings:
            print("\n⚠️  警告:")
            for warning in self.warnings:
                print(f"  - {warning}")
        
        if self.errors:
            print("\n❌ エラー:")
            for error in self.errors:
                print(f"  - {error}")
        
        print("\n" + "=" * 50)
        
        if self.errors:
            print("❌ 環境チェックに失敗しました。上記のエラーを修正してください。")
            return False
        elif self.warnings:
            print("⚠️  環境チェックは成功しましたが、警告があります。必要に応じて対応してください。")
            return True
        else:
            print("✅ 環境チェックが成功しました！開発を開始できます。")
            return True


def main():
    """メイン関数"""
    checker = EnvironmentChecker()
    success = checker.run_all_checks()
    
    if not success:
        sys.exit(1)


if __name__ == "__main__":
    main() 
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
run_examiner_analysis.py

008_create_detailed_input_analysis.pyと009_separate_cognitive_tasks.pyを
順番に実行して、Examinerデータの分析を行うスクリプト
"""

import os
import subprocess
import sys
from pathlib import Path

def run_script(script_path):
    """
    指定されたスクリプトを実行し、結果を表示する
    """
    print(f"\n{'='*80}")
    print(f"実行: {script_path}")
    print(f"{'='*80}\n")
    
    try:
        # スクリプトを実行
        result = subprocess.run(
            [sys.executable, script_path],
            check=True,
            text=True,
            capture_output=True
        )
        
        # 標準出力と標準エラー出力を表示
        if result.stdout:
            print(result.stdout)
        if result.stderr:
            print(f"STDERR: {result.stderr}")
            
        print(f"\n[SUCCESS] {script_path} の実行が完了しました")
        return True
    except subprocess.CalledProcessError as e:
        print(f"[ERROR] スクリプトの実行に失敗しました: {e}")
        if e.stdout:
            print(f"STDOUT: {e.stdout}")
        if e.stderr:
            print(f"STDERR: {e.stderr}")
        return False

def main():
    # プロジェクトのルートディレクトリを取得
    project_root = Path(__file__).resolve().parent.parent
    
    # 実行するスクリプトのパス
    script1 = project_root / "analysis_steps" / "008_create_detailed_input_analysis.py"
    script2 = project_root / "analysis_steps" / "009_separate_cognitive_tasks.py"
    
    # スクリプトの存在確認
    if not script1.exists():
        print(f"[ERROR] スクリプトが見つかりません: {script1}")
        return False
        
    if not script2.exists():
        print(f"[ERROR] スクリプトが見つかりません: {script2}")
        return False
    
    # スクリプトを順番に実行
    print("\n[INFO] Examinerデータ分析を開始します...")
    
    # 1. 008_create_detailed_input_analysis.py を実行
    if not run_script(script1):
        print("[ERROR] 008_create_detailed_input_analysis.py の実行に失敗しました")
        return False
    
    # 2. 009_separate_cognitive_tasks.py を実行
    if not run_script(script2):
        print("[ERROR] 009_separate_cognitive_tasks.py の実行に失敗しました")
        return False
    
    print("\n[INFO] すべての処理が完了しました")
    return True

if __name__ == "__main__":
    success = main()
    sys.exit(0 if success else 1) 
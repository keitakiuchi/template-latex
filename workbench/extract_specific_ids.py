#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
extract_specific_ids.py

指定されたIDを持つ行を抽出してCSVに出力するスクリプト
"""

import pandas as pd
from pathlib import Path

def main():
    # 入力ファイルと出力ファイルのパス
    input_file = "/home/keitakiuchi/0_projects/detachment2025/data/examiner_pretreated.csv"
    output_file = "/home/keitakiuchi/0_projects/detachment2025/workbench/extracted_ids.csv"
    
    # 抽出対象のID
    target_ids = [
        'awt3is0tssgn', 'dukgwvdkzxxe', 'hiqlqtr9hjmu', 'koka81uomilt', 
        'kvmmzlphrt3d', 'l7wss2c7wjcm', 'lskaje4fwdjm', 'mgbmrl2tdqmh', 
        'np1hesseiuc6', 'r1k7zrhdg2m8', 'semerjmgcenj', 'tsqxwoblghmm', 
        'wcwpdxwekfwx', 'x703753', 'zjxfzmssl3ec'
    ]
    
    print(f"Reading data from {input_file}...")
    df = pd.read_csv(input_file, encoding="utf-8-sig")
    
    # 指定されたIDを持つ行を抽出
    filtered_df = df[df['id'].isin(target_ids)]
    
    # 結果の概要を表示
    print(f"\nExtracted {len(filtered_df)} rows for {len(filtered_df['id'].unique())} unique IDs")
    
    # 各IDの行数を表示
    id_counts = filtered_df['id'].value_counts()
    print("\nRows per ID:")
    for id_val, count in id_counts.items():
        print(f"  {id_val}: {count} rows")
    
    # CSVに出力
    filtered_df.to_csv(output_file, index=False, encoding="utf-8-sig")
    print(f"\nSaved filtered data to {output_file}")

if __name__ == "__main__":
    main() 
# --- 1) pandas を使う場合 ---------------------------------
# 事前に `pip install pandas` でインストールしてください

import pandas as pd

csv_path = "/home/keitakiuchi/0_projects/detachment2025/data/detachment_2025_combined.csv"

# UTF-8 に BOM（バイト順マーク）が含まれている可能性を考慮して 'utf-8-sig' を指定
df = pd.read_csv(csv_path, encoding="utf-8-sig")

# 列名をリスト形式で表示
print(df.columns.tolist())

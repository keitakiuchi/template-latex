# AIGENIE 項目作成テンプレート

このディレクトリは、AIGENIE/GENIE を使って尺度項目プールを作成・改善するためのクリーンなテンプレートです。

## 編集するファイル

- `inputs/item_pool.csv`: 既存項目文とメタデータ。
- `inputs/type_attribute_labels.csv`: type / attribute のラベルと定義。
- `inputs/generation_targets.csv`: どの attribute に候補項目を生成するか。
- `inputs/prompt_notes.txt`: AIGENIE の項目生成に渡す追加指示。
- `task_plan.md`: プロジェクト別の作業チェックリスト。

`inputs/` は実プロジェクト用の入力置き場です。サンプルは `examples/inputs/` にあります。

新しいプロジェクトでは、必要に応じてサンプルをコピーしてから編集します。

```bash
cp examples/inputs/item_pool.csv inputs/item_pool.csv
cp examples/inputs/type_attribute_labels.csv inputs/type_attribute_labels.csv
cp examples/inputs/generation_targets.csv inputs/generation_targets.csv
cp examples/inputs/prompt_notes.txt inputs/prompt_notes.txt
```

## 必須列

`inputs/item_pool.csv` must include:

```text
ID,statement,type,attribute,origin
```

Optional label columns are supported and preserved when present:

```text
type_label_ja,attribute_label_ja
```

`inputs/type_attribute_labels.csv` must include:

```text
type,attribute,type_label_ja,attribute_label_ja,type_definition_en,attribute_definition_en
```

`inputs/generation_targets.csv` must include:

```text
generate,generation_group,type,attribute,n_candidates,generation_group_definition_en
```

`generate=TRUE` の `generation_group` には、少なくとも2つの attribute を入れてください。AIGENIE は生成グループ内に複数 attribute がある前提で動きます。

## API と秘密情報

これらのスクリプトは項目文を OpenAI API に送信することがあります。AIGENIE または GENIE を呼ぶスクリプトを実行する前に、項目文を外部 API に送信してよいことを確認してください。

`OPENAI_API_KEY` はシェル環境変数、またはリポジトリ直下の `.env` に設定します。`.env` の中身は出力・コミットしないでください。

## 環境チェック

リポジトリ直下で以下を実行します。

```bash
python utility/check_env.py
```

AIGENIE が R から読み込めない場合はインストールします。

```r
install.packages(
  "AIGENIE",
  repos = c("https://laralee.r-universe.dev", "https://cloud.r-project.org")
)
```

プロジェクトごとのローカル R ライブラリが必要な場合は `R/library/` に置けます。このディレクトリは Git では無視されます。

## よく使うコマンド

既存項目だけで GENIE を実行します。

```bash
Rscript "3_item_building/AIGENIE/scripts/01_run_genie_existing_items.R"
```

追加候補項目を生成します。

```bash
Rscript "3_item_building/AIGENIE/scripts/02_generate_missing_candidates.R"
```

既存項目と生成候補を結合して GENIE を実行します。

```bash
Rscript "3_item_building/AIGENIE/scripts/03_run_genie_combined_items.R"
```

埋め込み類似度による重複診断を実行します。

```bash
Rscript "3_item_building/AIGENIE/scripts/04_run_embedding_redundancy.R"
```

出力は `outputs/` に保存され、Git では無視されます。

## 主な環境変数

- `AIGENIE_BASE_DIR`: このテンプレートディレクトリを明示指定する。
- `AIGENIE_ITEM_POOL`: 項目プール CSV のパスを上書きする。
- `AIGENIE_LABEL_TABLE`: ラベル表 CSV のパスを上書きする。
- `AIGENIE_GENERATION_TARGETS`: 生成対象 CSV のパスを上書きする。
- `AIGENIE_PROMPT_NOTES`: 追加プロンプトのテキストファイルを上書きする。
- `AIGENIE_DOMAIN`: AIGENIE 生成時に渡す研究領域。
- `AIGENIE_SCALE_TITLE`: AIGENIE 生成時に渡す尺度名。
- `AIGENIE_AUDIENCE`: AIGENIE 生成時に渡す対象者。
- `AIGENIE_RESPONSE_OPTIONS`: `|` 区切りの回答選択肢。
- `AIGENIE_LLM_MODEL`: 候補生成に使う LLM モデル。
- `AIGENIE_EMBEDDING_MODEL`: GENIE や重複診断に使う embedding モデル。
- `AIGENIE_BOOT_ITER`: GENIE スクリプトの BootEGA 反復数。
- `AIGENIE_BOOT_NCORES`: BootEGA で使うコア数。

## レビュー方針

生成項目と GENIE の削減結果は判断補助です。最終的な項目の採否は、内容妥当性、理論的カバレッジ、回答負担、実データでの検証を合わせて判断してください。

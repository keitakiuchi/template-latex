# AIGENIE テンプレート作業計画

## 目的
AIGENIE/GENIE を使って尺度項目プールを作成・改善する。入力、スクリプト、出力の関係を再現可能な形で残す。

## フェーズ

- [ ] `examples/inputs/` を参考に、対象プロジェクト用の入力ファイルを `inputs/` に作成する。
- [ ] `inputs/item_pool.csv` に対象プロジェクトの項目を入れる。
- [ ] `inputs/type_attribute_labels.csv` に対象プロジェクトの type / attribute 定義を入れる。
- [ ] `inputs/generation_targets.csv` で生成対象の attribute と候補数を設定する。
- [ ] `inputs/prompt_notes.txt` と `AIGENIE_*` 環境変数を確認する。
- [ ] 項目文の OpenAI API 送信が承認済みであれば、既存項目の GENIE 診断を実行する。
- [ ] AIGENIE で候補項目を生成する。
- [ ] 生成候補を人間が確認する。
- [ ] 結合項目プールの GENIE または埋め込み重複診断を実行する。
- [ ] 追加候補、重複候補、人間判断の結果を要約する。

## 注意

- `.env`、API キー、ログ、生成済み `outputs/` はコミットしない。
- OpenAI embeddings や LLM 生成を使う場合、項目文は外部 API へ送信される入力として扱う。
- GENIE の結果だけで項目の採否を自動決定しない。

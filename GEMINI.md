# GEMINI.md

## 概要

Gemini CLI / API をこのリポジトリで活用する際のルールをまとめたガイドです。Claude や Codex と並行して利用し、情報収集や指示生成を補助します。運用方針は `ai-driven-coding.md` をベースにしています。

---

## 初期セットアップ

1. `python utility/start.py` または `INSTALL_DEPS=true ./utility/start.sh` を実行し、LaTeX と Python 環境を確認する。
2. `plan/` に Gemini を使う目的を書き留める（例: 用語調査、図の説明作成など）。
3. 参照が必要なファイルがあれば相対パス付きでメモしておく。

---

## 推奨ワークフロー

1. Gemini で検索が必要な場合は `.claude/commands/gemini-search.md` のテンプレートを参考にプロンプトを組み立てる。
2. 取得した情報は Issue / PR コメント、もしくは `results/` 配下の Markdown に整理する。
3. 生成された下書き（セクション文・図説明など）は `tex/` へ反映する前にローカルで内容を確認し、`./scripts/compile.sh` を実行して PDF をチェックする。
4. 倫理的に疑わしい、もしくは正確性が明確でない情報は Gemini の出力段階で除外し、一次情報のリンクだけを残す。

---

## ログの扱い

- 調査ログや要約は `results/` に日付付きファイル名で保存することを推奨。
- 試行錯誤的なプロンプトやメモは `workbench/` に置き、成果につながった内容のみを `plan/` や Issue に昇格させる。

---

## ベストプラクティス

- LaTeX の図表説明を生成する際は `figures/` の画像を確認し、正しいキャプションかをチェックする。
- `ai-driven-coding.md` の品質チェックリストに従い、Gemini の出力を採用する前に最低限 1 回は LaTeX ビルドを走らせる。
- Gemini で得た情報に出典がある場合は BibTeX エントリを `tex/bib/refs.bib` に追加し、本文に `\cite{}` を記述する。

---

## トラブルシューティング

| 症状 | 対応 |
|------|------|
| API キーが認識されない | 環境変数の設定と CLI のログを確認する。必要なら `results/` にログを保存し共有。 |
| 出力が長すぎて Issue に貼りづらい | `results/` に Markdown として保存し、要約だけを Issue / PR に貼り付ける。 |
| LaTeX で誤った書式を生成した | `utility/check_env.py` で環境を確認した上で手動で修正し、修正内容を `plan/` に記録する。 |

---

Gemini の利用状況や追加ルールが必要になった場合はこのファイルを更新し、`sharing/ai-driven-coding.py` で所在を確認してください。

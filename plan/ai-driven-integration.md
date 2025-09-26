# AI駆動開発 対応プラン

## 目的
- `template-latex` リポジトリを AI エージェント（Claude, Codex, Gemini など）と連携しやすい構造へ整備する。
- `ai-driven-coding.md` をプロジェクト固有の情報で更新し、各ツールから参照できるようにする。

## 実施内容
- `.codex/config.toml` を追加し、Codex CLI/IDE の既定設定を定義。
- `ai-driven-coding.md` のプレースホルダーを `template-latex` 用に置換。
- `sharing/ai-driven-coding.py` に Codex ルールファイルの所在を追記。
- `tex/main.tex`・`tex/preamble.tex`・`tex/title.tex` を整備し、`refs.bib` を導入。
- GitHub Actions (`.github/workflows/latex.yml`) を最新の `latexmk` フローに更新。

## 制約
- リポジトリルート直下の構成ルール（LaTeX ファイルは `tex/`、図版は `figures/`）。
- 環境チェックは作業開始時に `python utility/start.py` を実行すること。
- 成果物ログは `results/`、試行やメモは `workbench/` に保存する。

## 今後のタスク候補
- LuaLaTeX 用フォントの既定化と CI 上での確認（`haranoaji` / `ipa` 系の導入確認）。
- GitHub Actions での AI 支援ワークフロー（Claude/Codex）の動作確認。
- 各 AI ガイドラインファイルの定期レビューと更新。
- `ai-driven-coding.md` を短縮版と詳細版に分割する検討。

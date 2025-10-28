# Cursor Rules for LaTeX Template

## 目的

- Cursor AI 機能を利用する際に、LaTeX テンプレート特有の構成とワークフローを維持する
- Claude / Gemini と連携した検索・補助を安全かつ再現性高く進める

---

## 必須チェック

1. `python utility/check_env.py` を実行して `latexmk`、`lualatex`、主要ディレクトリが揃っているか確認する  
2. `utility/start.py` または `utility/start.sh` で初回セットアップを行う  
3. Gemini WebSearch を利用する場合は `.claude/commands/gemini-search.md` を参照し、具体的なクエリを準備する  
4. Codex CLI を使う前に `.codex/config.toml` のモデル・承認設定が最新か確認する  
5. 共有テンプレートを配布する際は `python sharing/ai-driven-coding.py` で `sharing/ai-driven-coding.md` を再生成する

---

## プロジェクト構造

```
.codex/            # Codex CLI/IDE 設定
.claude/           # Claude 設定
tex/               # LaTeX 本文
figures/           # 画像・図表
build/pdf/         # 生成された PDF
utility/           # 環境チェックとセットアップ
plan/              # スプリント計画とメモ
workbench/         # 実験用スクリプトと結果
results/           # 共有用成果物
sharing/           # ai-driven-coding テンプレート
environment.yml    # conda 補助環境定義 (latex-template)
```

- セクションは `tex/sections/` に追加し、`tex/main.tex` から `\input{sections/...}` で読み込む
- 参考文献は `tex/bib/refs.bib` に追加する
- 実験コードは `workbench/scripts/` に保存し、本番コードと混在させない

---

## 編集ガイドライン

- LaTeX コードは既存スタイル（半角スペース・コメント形式）に合わせる
- 生成コードは `workbench/` で検証後に `tex/` へ反映する
- 画像を追加する場合は `figures/` に保存し、TeX から `../figures/...` で参照する
- 大きな変更は `plan/current-sprint.md` に記録し、再現手順を残す
- `sharing/ai-driven-coding.py` でルールテンプレートを再生成し、共有用の Markdown を最新化する
- `environment.yml` を更新した際は `conda env update --file environment.yml --name latex-template` の実行手順を共有する

---

## 推奨ワークフロー

1. Cursor で編集提案を生成  
2. `workbench/scripts/test_ai_integration.py` や `scripts/compile.sh` でビルドを確認  
3. 問題なければ `tex/` やドキュメントへ反映  
4. 変更点・参考 URL を `plan/current-sprint.md` にメモ  
5. 必要に応じて `CLAUDE.md` / `GEMINI.md` を更新し、ガイドラインを共有

---

## 注意点

- 生成物（PDF 等）をコミットしない（`build/` は CI で生成）  
- LaTeX エラーはログとともに共有すると AI の改善提案が得やすい  
- API キーは `.env` や秘密管理で保持し、リポジトリに含めない  
- Codex CLI の設定は `.codex/config.toml` に集約されるため、不要なプロファイル変更は避ける

# AI-Driven Coding Rules for Cursor

## 概要

`template-latex` リポジトリで Cursor を使う際の AI 駆動開発ガイドです。LaTeX 文書生成が中心のため、環境チェックとビルドプロセスを最優先に整備しています。AI アシスタントに依頼する場合も、このドキュメントに沿って手順を共有してください。

## 🚀 自動スタート機能

ユーザーが「スタート」と入力した場合、AI アシスタントは必ず次のコマンドを実行します。

```bash
python utility/start.py
```

このスクリプトは以下を行います。
1. Conda 仮想環境 (`py-latex` など) の存在とアクティブ状態を確認
2. `utility/check_env.py` を用いたリポジトリ整合性チェック
3. 追加のセットアップ手順が必要な場合はログに案内

## 環境チェック（必須）

コードやビルドコマンドを実行する前に、次の 2 ステップを確実に行ってください。

```bash
conda activate py-latex   # または利用中の仮想環境名
python utility/check_env.py
```

チェック項目:
- `latexmkrc` と `tex/main.tex` の存在確認
- `latexmk` / `lualatex` の導入確認
- `figures/` や `requirements.txt` の有無

## ディレクトリ構成の要点

```
template-latex/
├── tex/                  # LaTeX ソース (main.tex がエントリーポイント)
│   ├── preamble.tex      # 共通パッケージ設定
│   ├── title.tex         # タイトルとフロントマター
│   ├── sections/         # 本文セクション (intro.tex など)
│   └── bib/refs.bib      # 参考文献データベース
├── figures/              # 図版・画像 (tex からは ../figures/ で参照)
├── build/pdf/            # `latexmk` 実行後に生成される PDF
├── utility/              # start.py / check_env.py などのユーティリティ
├── plan/                 # タスク計画メモ
├── results/              # 実行結果やビルドログ
├── workbench/            # 検証用スペース
└── ai-driven-coding.md   # AI ガイドライン統合ドキュメント
```

## 開発フロー

1. **環境初期化**: 「スタート」または `python utility/start.py`
2. **プラン共有**: 変更が複数ステップになる場合は `plan/` の内容を参照・更新
3. **作業実施**: LaTeX ファイル (`tex/`) を編集。構造を崩さずに `\input{}` で連結
4. **ビルド**: `cd tex && latexmk -lualatex -synctex=1 -interaction=nonstopmode main.tex`
   - IPA フォントが見つからない場合は `luaotfload-tool --update` や `texlive-lang-japanese` の導入を案内
5. **成果物管理**: 生成ファイルは `build/pdf/`、ログは `results/` へ
6. **振り返り**: `sharing/ai-driven-coding.py` を実行するとルールファイルの所在を一覧表示

## AI への指示テンプレート

- **リサーチ**: 「Gemini CLI で最新の LaTeX パッケージ情報を検索して」
- **ビルド**: 「latexmk を使って tex/main.tex をビルドし、エラーが出たらログを要約して」
- **修正**: 「tex/sections/intro.tex にセクションを追加。ただし `tex/preamble.tex` のパッケージ整合性を保つこと」
- **レビュー**: 「.github/workflows/latex.yml を読み、CI が main.tex を生成できるか確認して」

## ベストプラクティス

- LaTeX ファイルは UTF-8 (BOM なし)・インデント 2 または 4 スペース推奨
- 新しいセクションは `tex/sections/` に追加し、`tex/main.tex` から `\input{}`
- 参考文献は必ず `tex/bib/refs.bib` にまとめる
- 図版は `figures/` 直下に配置し、相対パス `../figures/...` で参照
- プルリクやレビューでは `python utility/start.py` の実行結果を添付

## AI ツールの連携

- **Claude / Codex**: `.codex/config.toml` 参照。仮想環境チェック後にコマンドを投げる
- **Gemini CLI**: `.claude/commands/gemini-search.md` に利用例あり
- **Cursor**: `.cursor/rules/latex_development.md` で LaTeX 特化ルールを確認

このガイドを AI セッション開始時に読ませることで、Cursor でもリポジトリ状況に即したアシスタンスを得られます。

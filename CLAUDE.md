# CLAUDE.md - AI-Driven Coding Support

## 概要

本ドキュメントは、LaTeX テンプレートリポジトリにおける Claude AI アシスタントの設定・活用方法を整理したものです。
GitHub Actions による CI/CD と Claude AI アシスタントを組み合わせることで、LaTeX ドキュメント作成の効率化を図ります。

## AI駆動コーディング対応

### 対応AIツール
- **Claude Code CLI**: コード生成・改善・レビュー
- **Claude Code GitHub Actions**: CI/CD統合  
- **OpenAI Codex**: コード補完・生成
- **Gemini CLI**: ウェブ検索・技術情報取得
- **Cursor**: AI統合開発環境

### 環境チェック（必須）
**このプロジェクトでコードを実行する前に、必ず環境チェックスクリプトを実行してください：**

```bash
# 仮想環境のアクティベート
conda activate py-latex  # または適切な環境名

# 環境チェックスクリプトの実行
python utility/check_env.py
```

このスクリプトは以下を確認します：
- ✅ 適切な仮想環境がアクティブか
- ✅ 必要な依存関係がインストールされているか
- ✅ 設定ファイルが存在するか

### クイックスタート機能
「スタート」と入力すると、自動的に環境チェックを実行して処理環境を整えます：

```bash
# スタートスクリプトの実行
python utility/start.py
```

### AIツールの使用方法

#### Claude AI アシスタント
- GitHub Issuesで@claudeをメンション
- プルリクエストレビューで@claudeをメンション
- 自動化されたコードレビューと改善提案

#### Gemini CLI 検索
```bash
# 技術情報の検索
gemini --prompt "WebSearch: Python async programming best practices 2024"

# APIドキュメントの検索
gemini --prompt "WebSearch: OpenAI API documentation"

# ベストプラクティスの検索
gemini --prompt "WebSearch: GitHub Actions best practices"
```

#### Cursor IDE
- `.cursor/rules/` ディレクトリのルールファイルを参照
- AI駆動開発のベストプラクティスに従った開発

---

## Claude ワークフローでの共通ステップ

1. `python utility/start.py` で環境チェックを実行し、LaTeX ツールチェーンが整っていることを確認する。
2. 作業の目的と入力ファイルを `plan/` にメモとして残す。
3. Claude への依頼内容には対象ファイルパスと期待するアウトプットを明記し、完了後は `results/` にログを保存する。
4. `sharing/ai-driven-coding.py` を実行してルール類の所在が揃っているか確認し、不足があれば本ドキュメントを更新する。
5. 生成物を受け取ったら `./scripts/compile.sh` で LaTeX を再ビルドし、PDF をレビューする。

---

## 設定ファイルの役割と責務

### .github/workflows/latex.yml：GitHub Actions の設定

#### 目的

- LaTeX ドキュメントのビルドを自動化
- PDF の生成とアーティファクトとしての保存
- リリースの自動作成

#### 変更が必要となるタイミング

- LaTeX コンパイラの変更（例：platex → xelatex）
- 追加パッケージのインストールが必要になった場合
- ビルド条件やトリガーの変更

---

### .claude/claude.yml：Claude AI アシスタントの設定

#### 目的

- Claude セッション中に適用されるルールの定義（system_prompt）
- LaTeX プロジェクト構造の理解を支援
- 使用可能なコマンド（allowed_tools）の制限

#### 変更が必要となるタイミング

- ディレクトリ構造やファイル配置ルールの変更
- 使用ツールや応答テンプレートの更新
- Claude の動作チューニング

---

## ファイル保存ポリシー

### LaTeX ソースファイル

- すべて `tex/` ディレクトリに保存すること
- メインファイルは `tex/main.tex`
- プリアンブルは `tex/preamble.tex`
- セクションファイルは `tex/sections/` に配置
- 参考文献は `tex/bib/refs.bib` に記述

### 図表・画像ファイル

- すべて `figures/` ディレクトリに保存すること
- LaTeX ファイルからは `../figures/` として参照（graphicspath 設定済み）

### ビルド成果物

- ビルド中間ファイルは `tex/build/` に出力
- 最終 PDF は `tex/` ディレクトリのルートに生成
- `.gitignore` により中間ファイルは Git 管理対象外

---

## LaTeX 実行ルール

### 1. コンパイル方法

#### VS Code / Cursor を使用する場合

```bash
# LaTeX Workshop 拡張機能のビルドボタンをクリック
# または Ctrl+Alt+B (Mac: Cmd+Alt+B) を押す
```

#### コマンドラインを使用する場合

```bash
cd tex
latexmk -pdf main.tex
```

### 2. クリーンアップ

```bash
cd tex
latexmk -C
```

---

## LaTeX コード記述規約

### 日本語対応

- 日本語文書には CJKutf8 と xeCJK パッケージを使用（preamble.tex に設定済み）
- コンパイルには platex または xelatex を使用

### コードスタイル

- インデントは一貫して 2 または 4 スペースを使用
- 関連するコマンドはグループ化
- 複雑なセクションやマクロにはコメントを追加
- LaTeX コマンドの大文字小文字は一貫させる

---

## Claude AI アシスタントによる支援

### LaTeX 文書編集

- 新しいセクションの作成
- 参考文献の追加・編集
- 図表の挿入コードの生成
- 数式の記述支援

### エラー診断と解決

- LaTeX コンパイルエラーの解析
- 修正案の提示
- パッケージの推奨

### ベストプラクティス

- LaTeX の文書構造に関するアドバイス
- 効率的なマクロの提案
- 一貫したスタイルの維持

---

## 開発ワークフロー

### 1. 文書構造の設計

- `tex/main.tex` でドキュメントの基本構造を定義
- 必要なセクションファイルを `tex/sections/` に作成
- `tex/preamble.tex` で必要なパッケージを追加

### 2. 内容の執筆

- 各セクションファイルに内容を記述
- 図表は `figures/` に配置し、LaTeX から参照
- 参考文献は `tex/bib/refs.bib` に追加

### 3. ビルドとレビュー

- VS Code / Cursor または latexmk でビルド
- PDF を確認し、必要に応じて修正
- Git でコミットし、変更を記録

### 4. CI/CD と公開

- GitHub へのプッシュで自動ビルド
- PDF がアーティファクトとして保存
- main ブランチへのプッシュでリリース作成

---

## Claude AI アシスタント活用のベストプラクティス

- 明確な指示を与える（例：「新しいセクションファイルを作成して」）
- LaTeX の特定の機能について質問する（例：「表の作り方を教えて」）
- エラーメッセージを共有して解決策を求める
- プロジェクト構造に従った提案を求める
- 日本語と英語の混在文書の最適な書き方を相談する

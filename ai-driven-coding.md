# AI-Driven Coding Rules Template

このファイルは、jpr-llm-evaluationリポジトリで使用するAI駆動コーディングのルールテンプレートです。
template-vibe-codingリポジトリから自動生成され、jpr-llm-evaluationプロジェクト用にカスタマイズされました。

## 生成日時
2025-07-02 14:46:17

## 概要
このファイルには、様々なAIツール向けのルールファイルが含まれています：
- Claude Code CLI
- Claude Code GitHub Actions  
- OpenAI Codex
- Gemini CLI
- Cursor

## ⚠️ 重要な注意事項

### プロジェクト固有の設定
このテンプレートは、jpr-llm-evaluationプロジェクト用に以下の設定でカスタマイズされています：

1. **環境名**: `conda activate py-latex`
2. **パス**: `python utility/check_env.py`
3. **プロジェクト名**: `jpr-llm-evaluation`

### 使用方法
1. このファイルをプロジェクトのルートディレクトリに配置
2. 上記の設定をプロジェクトに合わせて変更
3. 各AIツールの設定ファイルで参照
4. プロジェクトの要件に合わせてカスタマイズ

### 必要なファイル・ディレクトリの作成
このテンプレートで参照されているファイルが存在しない場合は、以下の内容で作成してください：

#### utility/check_env.py
```python
#!/usr/bin/env python3
# Environment check script
# Check if the project execution environment is properly configured.

import sys
import os

def check_environment():
    # Execute environment check
    print("🔍 Checking environment...")
    
    # Check virtual environment
    if hasattr(sys, 'real_prefix') or (hasattr(sys, 'base_prefix') and sys.base_prefix != sys.prefix):
        print("✅ Virtual environment is active")
    else:
        print("⚠️ Virtual environment is not active")
    
    # Check Python version
    print(f"✅ Python version: {sys.version}")
    
    # Check required directories
    required_dirs = ['.claude', '.cursor', '.github']
    for dir_name in required_dirs:
        if os.path.exists(dir_name):
            print(f"✅ {dir_name}/ directory exists")
        else:
            print(f"⚠️ {dir_name}/ directory does not exist")
    
    print("✅ Environment check completed")

if __name__ == "__main__":
    check_environment()
```

#### ディレクトリ構造
```
jpr-llm-evaluation/
├── .claude/          # Claude Code CLI設定
│   └── commands/     # AIコマンド
├── .cursor/          # Cursor設定
│   └── rules/        # AI駆動開発ルール
├── .github/          # GitHub Actions設定
├── utility/          # ユーティリティツール
├── tex/              # LaTeXソースファイル
└── ai-driven-coding.md  # このテンプレートファイル
```

---

## Claude Code CLI

# .claude/commands/gemini-search.md

# Gemini Search Command

## 概要

このファイルは、Claude AI アシスタントで Gemini CLI ツールを使用したウェブ検索機能の設定を定義しています。
最新の技術情報やドキュメントを効率的に検索するためのガイドラインです。

---

## ⚠️ 重要な注意事項

### 環境チェックの実行
**このプロジェクトでコードを実行する前に、必ず環境チェックスクリプトを実行してください：**

```bash
# 仮想環境のアクティベート
conda activate env-example  # プロジェクトに適した環境名に変更してください  # または適切な環境名

# 環境チェックスクリプトの実行
python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください
```

このスクリプトは以下を確認します：
- ✅ 適切な仮想環境がアクティブか
- ✅ 必要な依存関係がインストールされているか
- ✅ 設定ファイルが存在するか

### 仮想環境の管理
- **Pythonプロジェクト**: `conda activate env-example  # プロジェクトに適した環境名に変更してください` または適切な仮想環境
- **Node.jsプロジェクト**: `npm install` で依存関係をインストール
- **環境変数**: APIキーは `.env` ファイルで管理

---

## Gemini CLI ツールの概要

### 目的
- **ウェブ検索機能**: 最新の技術情報やドキュメントの検索
- **コード生成支援**: AI駆動でのコード生成と改善
- **開発効率化**: 開発プロセスの自動化と最適化

### 特徴
- **リアルタイム検索**: 最新の情報にアクセス
- **多言語対応**: 様々なプログラミング言語をサポート
- **コンテキスト理解**: プロジェクトの文脈を理解した提案
- **統合開発**: 他のAIツールとの連携

---

## 使用方法

### 基本的な検索コマンド

```bash
# 基本的な検索
gemini --prompt "WebSearch: <検索クエリ>"

# 技術的な検索例
gemini --prompt "WebSearch: Python async programming best practices 2024"
gemini --prompt "WebSearch: React hooks performance optimization"
gemini --prompt "WebSearch: Docker containerization best practices"
```

### 開発関連の検索例

#### 1. 技術トレンドの調査
```bash
# 最新の開発トレンド
gemini --prompt "WebSearch: latest Python development trends 2024"
gemini --prompt "WebSearch: JavaScript framework comparison 2024"
gemini --prompt "WebSearch: cloud computing trends 2024"
```

#### 2. ベストプラクティスの検索
```bash
# コーディング規約
gemini --prompt "WebSearch: Python PEP 8 style guide"
gemini --prompt "WebSearch: JavaScript ES6+ best practices"
gemini --prompt "WebSearch: Git workflow best practices"
```

#### 3. API・ライブラリの調査
```bash
# APIドキュメント
gemini --prompt "WebSearch: OpenAI API documentation"
gemini --prompt "WebSearch: FastAPI tutorial examples"
gemini --prompt "WebSearch: React hooks documentation"
```

#### 4. 問題解決の検索
```bash
# エラー解決
gemini --prompt "WebSearch: Python ModuleNotFoundError solutions"
gemini --prompt "WebSearch: JavaScript CORS error handling"
gemini --prompt "WebSearch: Docker build failed troubleshooting"
```

#### 5. 自動化技術の調査
```bash
# テスト自動化
gemini --prompt "WebSearch: Selenium web automation best practices"
gemini --prompt "WebSearch: pytest testing framework examples"
gemini --prompt "WebSearch: GitHub Actions CI/CD examples"
```

---

## 開発ワークフローとの統合

### 1. プロジェクト初期化時

```bash
# プロジェクトテンプレートの検索
gemini --prompt "WebSearch: Python project structure best practices"
gemini --prompt "WebSearch: React project setup guide 2024"
gemini --prompt "WebSearch: microservices architecture patterns"
```

### 2. 新機能開発時

```bash
# 技術選定
gemini --prompt "WebSearch: Python web framework comparison 2024"
gemini --prompt "WebSearch: database ORM comparison Python"
gemini --prompt "WebSearch: authentication libraries Python"
```

### 3. パフォーマンス最適化時

```bash
# 最適化手法
gemini --prompt "WebSearch: Python performance optimization techniques"
gemini --prompt "WebSearch: React performance optimization 2024"
gemini --prompt "WebSearch: database query optimization strategies"
```

### 4. セキュリティ強化時

```bash
# セキュリティベストプラクティス
gemini --prompt "WebSearch: web application security best practices 2024"
gemini --prompt "WebSearch: API security authentication methods"
gemini --prompt "WebSearch: OWASP top 10 2024"
```

---

## 検索クエリの最適化

### 効果的なクエリ作成のコツ

#### 1. 具体的で詳細なクエリ
```bash
# 良い例
gemini --prompt "WebSearch: Python async programming with asyncio examples 2024"

# 悪い例
gemini --prompt "WebSearch: Python async"
```

#### 2. 年号を含める
```bash
# 最新情報を取得
gemini --prompt "WebSearch: React hooks best practices 2024"
gemini --prompt "WebSearch: Python type hints tutorial 2024"
```

#### 3. 特定の技術スタックを指定
```bash
# 具体的な技術を指定
gemini --prompt "WebSearch: FastAPI with PostgreSQL integration examples"
gemini --prompt "WebSearch: React with TypeScript setup guide"
```

#### 4. 問題解決に特化
```bash
# エラー解決に特化
gemini --prompt "WebSearch: Python ModuleNotFoundError virtual environment solutions"
gemini --prompt "WebSearch: Docker permission denied error solutions"
```

---

## 環境チェックとセットアップ

### 1. 環境チェック（必須）

```bash
# 1. 仮想環境のアクティベート
conda activate env-example  # プロジェクトに適した環境名に変更してください  # または適切な環境名

# 2. 環境チェックスクリプトの実行
python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください

# 3. 依存関係のインストール（必要に応じて）
pip install -r requirements.txt
```

### 2. Gemini CLI の設定

```bash
# Gemini CLI のインストール確認
gemini --version

# API キーの設定
export GEMINI_API_KEY="your-api-key-here"

# 設定の確認
gemini --help
```

### 3. 統合テスト

```bash
# 基本的な検索テスト
gemini --prompt "WebSearch: Python programming"

# 結果の確認
echo "検索結果を確認してください"
```

---

## ベストプラクティス

### 1. 検索戦略

#### 段階的な検索
```bash
# 1. 概要を把握
gemini --prompt "WebSearch: Python async programming overview"

# 2. 詳細を調査
gemini --prompt "WebSearch: Python asyncio detailed tutorial"

# 3. 実装例を検索
gemini --prompt "WebSearch: Python async web server examples"
```

#### 複数視点からの検索
```bash
# 異なる観点から検索
gemini --prompt "WebSearch: Python async programming benefits"
gemini --prompt "WebSearch: Python async programming challenges"
gemini --prompt "WebSearch: Python async vs threading comparison"
```

### 2. 情報の整理

#### 検索結果の記録
- 重要な情報をメモに記録
- 参考URLをブックマーク
- コード例を保存

#### 情報の検証
- 複数のソースで情報を確認
- 公式ドキュメントを優先
- 最新の情報を確認

### 3. 開発効率化

#### 定期的な情報更新
```bash
# 週次での技術トレンド確認
gemini --prompt "WebSearch: Python development trends this week"
gemini --prompt "WebSearch: JavaScript ecosystem updates"
```

#### プロジェクト固有の検索
```bash
# プロジェクトに関連する検索
gemini --prompt "WebSearch: <プロジェクト名> best practices"
gemini --prompt "WebSearch: <使用技術> integration examples"
```

---

## トラブルシューティング

### よくある問題と解決方法

#### 1. 検索結果が不適切な場合
```bash
# クエリをより具体的にする
gemini --prompt "WebSearch: Python async programming with asyncio library examples 2024"

# 年号を追加
gemini --prompt "WebSearch: React hooks tutorial 2024"
```

#### 2. API エラーが発生する場合
```bash
# API キーの確認
echo $GEMINI_API_KEY

# 環境変数の再設定
export GEMINI_API_KEY="your-api-key-here"
```

#### 3. 検索結果が古い場合
```bash
# 年号を明示的に指定
gemini --prompt "WebSearch: Python async programming 2024"

# 最新のキーワードを追加
gemini --prompt "WebSearch: Python async programming latest updates"
```

---

## セキュリティとプライバシー

### 1. API キーの管理

```bash
# 環境変数での管理（推奨）
export GEMINI_API_KEY="your-api-key-here"

# .env ファイルでの管理
echo "GEMINI_API_KEY=your-api-key-here" >> .env
```

### 2. 機密情報の保護

- API キーをGitにコミットしない
- 環境変数で機密情報を管理
- 定期的にAPI キーを更新

### 3. 検索履歴の管理

- 機密情報を含む検索を避ける
- 検索履歴を定期的にクリア
- プライバシー設定を確認

---

## 今後の拡張予定

### 1. 機能拡張

- **多言語検索**: 日本語での検索対応
- **コード生成**: 検索結果に基づくコード生成
- **統合開発**: 他のAIツールとの連携強化

### 2. パフォーマンス改善

- **検索速度**: 高速化とキャッシュ機能
- **結果精度**: より関連性の高い結果の提供
- **ユーザビリティ**: 使いやすいインターフェース

### 3. 開発者体験の向上

- **自動化**: 開発プロセスの自動化
- **テンプレート**: よく使う検索パターンのテンプレート化
- **学習機能**: 使用パターンに基づく提案機能

---

## まとめ

Gemini CLI ツールは、AI駆動コーディングプロジェクトにおいて非常に強力なツールです。
適切な環境チェックとベストプラクティスに従うことで、効率的な開発と高品質なコードの実現が可能になります。

**重要なポイント:**
1. **環境チェックの徹底**: コード実行前に必ず `python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください` を実行
2. **具体的な検索クエリ**: 詳細で具体的なクエリでより良い結果を得る
3. **最新情報の活用**: 年号を含めて最新の情報を取得
4. **セキュリティの確保**: API キーと機密情報の適切な管理
5. **継続的な学習**: 定期的な情報更新とベストプラクティスの習得

---

# .claude/claude.yml

# ------------------------------------------------------------
# 目的:
#   - AI駆動コーディングプロジェクトの汎用的なClaude設定
#   - 様々なプロジェクトタイプに対応した開発支援
#   - コード品質とベストプラクティスの実装
# ------------------------------------------------------------

system_prompt: |
  # AI駆動コーディング プロジェクト構造
  1. **プロジェクトの基本構造** を理解し、適切なディレクトリ配置を提案する。
     - ソースコード: `src/` または `app/` ディレクトリ
     - テスト: `tests/` ディレクトリ
     - 設定ファイル: `config/` ディレクトリ
     - ドキュメント: `docs/` ディレクトリ
     - スクリプト: `scripts/` ディレクトリ
     - ユーティリティ: `utility/` ディレクトリ
  
  # 環境チェック（重要）
  2. **コード実行前の環境チェック** を必ず実行する。
     - 仮想環境の確認: `conda activate env-example  # プロジェクトに適した環境名に変更してください` または適切な環境
     - 環境チェックスクリプトの実行: `python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください`
     - 依存関係の確認: `pip install -r requirements.txt`
     - 環境変数の設定: APIキーは `.env` ファイルで管理
  
  # 開発プロセス
  3. **テスト駆動開発（TDD）** を推奨する。
     - Red: 失敗するテストを書く
     - Green: テストを通す最小限のコードを書く
     - Refactor: コードを改善する
  4. **継続的リファクタリング** を実践する。
     - 小さな変更を頻繁に行う
     - テストが通ることを確認
     - 意味のある名前を使用
     - 重複を除去する
  
  # コード品質とテスト
  5. **コード品質標準** に従う。
     - 言語固有のコーディング規約（PEP 8 for Python, ESLint for JavaScript等）
     - 適切なdocstring/コメント記述
     - 型ヒントの使用（可能な場合）
     - エラーハンドリングの実装
  6. **テスト戦略** を実装する。
     - 単体テストの作成
     - 統合テストの実装
     - CI/CDパイプラインでの自動テスト
     - モックオブジェクトの活用

  # パフォーマンスとセキュリティ
  7. **パフォーマンス最適化** を考慮する。
     - 効率的なアルゴリズムの選択
     - キャッシュ機能の実装
     - 不要な処理の削減
     - メモリ使用量の最適化
  8. **セキュリティ** を重視する。
     - APIキーは環境変数で管理
     - 機密情報のGit管理を避ける
     - 入力値の検証
     - 定期的なセキュリティ監査の実施

  # ファイル編集ガイドライン
  9. **新しい機能の追加** 時:
      - 適切なディレクトリにファイルを作成
      - 基本クラス/関数構造を実装
      - 設定ファイルの更新
      - 適切なテストを追加
  10. **設定の追加** 時:
      - 設定ファイルの適切な形式（JSON, YAML, TOML等）を使用
      - 環境変数の設定を確認
      - デフォルト値の提供

  # エラーハンドリングとログ
  11. **エラーハンドリング** を適切に実装する。
      - 適切な例外処理
      - ログ出力の追加
      - リトライ機能の実装
      - ユーザーフレンドリーなエラーメッセージ

  # ドキュメントとコミット
  12. **ドキュメント** を適切に管理する。
      - README.mdの更新
      - APIドキュメントの作成
      - コードコメントの追加
  13. **コミット管理** を適切に行う。
      - 機能単位でのコミット
      - 意味のあるコミットメッセージ
      - 適切なブランチ戦略

# ---- ★ allowed_tools を改行区切りに修正 ★ ----
allowedTools: |
  Bash(:)
  Edit
  mcp__github_file_ops__commit_files

timeout_minutes: 30
concurrency:
  group: "claude"
  cancel-in-progress: false


---

# CLAUDE.md

# CLAUDE.md

## 概要

本ドキュメントは、AI駆動コーディングプロジェクトにおける Claude AI アシスタントの設定・活用方法を整理したものです。
GitHub Actions による CI/CD と Claude AI アシスタントを組み合わせることで、効率的な開発とコード品質の向上を図ります。

---

## ⚠️ 重要な注意事項

### 環境チェックの実行
**このプロジェクトでコードを実行する前に、必ず環境チェックスクリプトを実行してください：**

```bash
# 仮想環境のアクティベート
conda activate env-example  # プロジェクトに適した環境名に変更してください  # または適切な環境名

# 環境チェックスクリプトの実行
python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください
```

このスクリプトは以下を確認します：
- ✅ 適切な仮想環境がアクティブか
- ✅ 必要な依存関係がインストールされているか
- ✅ 設定ファイルが存在するか

### 仮想環境の管理
- **Pythonプロジェクト**: `conda activate env-example  # プロジェクトに適した環境名に変更してください` または適切な仮想環境
- **Node.jsプロジェクト**: `npm install` で依存関係をインストール
- **環境変数**: APIキーは `.env` ファイルで管理

---

## 設定ファイルの役割と責務

### .github/workflows/claude.yml：GitHub Actions の設定

#### 目的

- プロジェクトのテストを自動化
- 依存関係のインストールと検証
- Claude AI アシスタントの統合
- コード品質チェック（linting, formatting）の実行

#### 変更が必要となるタイミング

- 依存関係の変更
- 新しい機能の追加
- テスト条件やトリガーの変更
- コード品質標準の更新

---

### .claude/claude.yml：Claude AI アシスタントの設定

#### 目的

- Claude セッション中に適用されるルールの定義（system_prompt）
- プロジェクト構造の理解を支援
- 使用可能なコマンド（allowed_tools）の制限
- パフォーマンス最適化と品質保証のガイドライン

#### 変更が必要となるタイミング

- ディレクトリ構造やファイル配置ルールの変更
- 使用ツールや応答テンプレートの更新
- Claude の動作チューニング
- 新しい機能やベストプラクティスの追加

---

## プロジェクト構造ガイドライン

### ソースコードファイル

- メインソースコード: `src/` または `app/` ディレクトリ
- 設定ファイル: `config/` ディレクトリ
- スクリプト: `scripts/` ディレクトリ
- ドキュメント: `docs/` ディレクトリ
- ユーティリティ: `utility/` ディレクトリ

### テストファイル

- すべて `tests/` ディレクトリに保存すること
- 単体テスト: `tests/unit/`
- 統合テスト: `tests/integration/`
- テストデータ: `tests/fixtures/`

### 設定ファイル

- アプリケーション設定: `config/` ディレクトリ
- 環境変数: `.env`（機密情報用）
- Docker設定: `Dockerfile`, `docker-compose.yml`

---

## 開発プロセスガイドライン

### 1. 環境チェック（必須）

```bash
# 1. 仮想環境のアクティベート
conda activate env-example  # プロジェクトに適した環境名に変更してください  # または適切な環境名

# 2. 環境チェックスクリプトの実行
python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください

# 3. 依存関係のインストール（必要に応じて）
pip install -r requirements.txt
```

### 2. テスト駆動開発（TDD）

#### 基本サイクル

```bash
# 1. Red: 失敗するテストを書く
# 2. Green: テストを通す最小限のコードを書く
# 3. Refactor: コードを改善する
```

#### 実装例

```python
# 1. Red: 失敗するテスト
def test_calculate_total():
    calculator = Calculator()
    result = calculator.add(2, 3)
    assert result == 5

# 2. Green: 最小限の実装
class Calculator:
    def add(self, a, b):
        return a + b

# 3. Refactor: 改善
class Calculator:
    def add(self, a: int, b: int) -> int:
        """Add two numbers"""
        return a + b
```

### 3. 継続的リファクタリング

- 小さな変更を頻繁に行う
- テストが通ることを確認
- 意味のある名前を使用
- 重複を除去する

---

## コード記述規約

### 言語別の考慮事項

- **Python**: PEP 8ガイドライン、型ヒント、docstring
- **JavaScript**: ESLint、Prettier、JSDoc
- **TypeScript**: 型定義、ESLint、Prettier
- **Java**: Checkstyle、JUnit、JavaDoc

### コードスタイル

- 一貫したインデント（言語に応じて）
- 関連するメソッド/関数のグループ化
- 適切なコメント/docstring
- 言語固有のコーディング規約に従う
- 型ヒントの使用（可能な場合）

### エラーハンドリング

- 適切な例外処理の実装
- ログ出力の追加
- リトライ機能の実装
- ユーザーフレンドリーなエラーメッセージ

### テスト戦略

- 単体テストの作成
- 統合テストの実装
- モックオブジェクトの活用
- CI/CDパイプラインでの自動テスト

---

## Claude AI アシスタントによる支援

### 機能開発

- 新しい機能の実装
- 既存機能の改善・修正
- エラーハンドリングの実装
- パフォーマンス最適化

### 設定管理

- 設定ファイルの作成・更新
- 環境変数の設定
- 依存関係の管理

### ベストプラクティス

- 開発効率化に関するアドバイス
- アルゴリズムの改善
- 一貫したコードスタイルの維持
- セキュリティベストプラクティスの実装

### パフォーマンス最適化

- 効率的なアルゴリズムの選択
- キャッシュ機能の追加
- メモリ使用量の最適化
- 不要な処理の削減

---

## Gemini Search の使用方法

### 概要

`gemini` は Google Gemini CLI ツールで、ウェブ検索機能を提供します。**ウェブ検索が必要な場合、組み込みの `Web_Search` ツールの代わりにこのコマンドを使用する必要があります。**

### 使用方法

ウェブ検索は Task Tool 経由で `gemini --prompt` コマンドを使用して実行します：

```bash
gemini --prompt 'WebSearch: <query>'
```

### 実行例

```bash
# 最新の開発トレンドを検索
gemini --prompt "WebSearch: latest Python development trends 2024"

# ベストプラクティスを検索
gemini --prompt "WebSearch: GitHub Actions best practices"

# APIドキュメントを検索
gemini --prompt "WebSearch: OpenAI API documentation"

# 自動化技術を検索
gemini --prompt "WebSearch: Selenium web automation best practices"

# プロジェクトテンプレートを検索
gemini --prompt "WebSearch: AI-driven coding templates"
```

### 重要な注意事項

- **常に `gemini --prompt` を使用し、組み込みのWeb_Searchツールは使用しない**
- **クエリの前に "WebSearch: " を付ける**
- **Task Toolを使用してコマンドを実行する**
- **具体的で詳細な検索クエリを提供してより良い結果を得る**

### 開発ワークフローとの統合

- 新しい技術やAPIの調査にGemini Searchを使用
- 最新の開発ツールやライブラリの検索
- 技術的な問題やエラーの解決策を検索
- コード最適化のベストプラクティスを調査
- プロジェクトの参考資料や例を検索


---

## Claude Code GitHub Actions

# .github/workflows/claude.yml

name: Claude AI Assistant CI/CD

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]
  issue_comment:
    types: [created]
  pull_request_review:
    types: [submitted]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
    
    - name: Environment Check
      run: |
        echo "🔍 環境チェックを実行中..."
        echo "✅ Python バージョン: $(python --version)"
        echo "✅ pip バージョン: $(pip --version)"
        echo "✅ 作業ディレクトリ: $(pwd)"
        echo "✅ 依存関係の確認..."
        python -c "import sys; print('✅ Python パス:', sys.path)"
    
    - name: Run tests
      run: |
        echo "🧪 テストを実行中..."
        python -m pytest tests/ --cov=src --cov-report=xml
    
    - name: Run linting
      run: |
        echo "🔍 コード品質チェックを実行中..."
        flake8 src/ --max-line-length=88 --count --select=E9,F63,F7,F82 --show-source --statistics
        black --check src/ --diff
    
    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v3
      with:
        file: ./coverage.xml
        flags: unittests
        name: codecov-umbrella

  claude-assistant:
    runs-on: ubuntu-latest
    if: github.event_name == 'issue_comment' && contains(github.event.comment.body, '@claude')
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
    
    - name: Environment Check
      run: |
        echo "🔍 Claude AI アシスタント用の環境チェックを実行中..."
        echo "✅ Python 環境: $(python --version)"
        echo "✅ 依存関係の確認..."
        python -c "import requests, json, os; print('✅ 必要なライブラリが利用可能')"
    
    - name: Claude AI Assistant
      env:
        ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
      run: |
        echo "🤖 Claude AI アシスタントを実行中..."
        # Claude AI アシスタントの処理をここに実装
        # 実際の実装はプロジェクトの要件に応じて調整

  claude-review:
    runs-on: ubuntu-latest
    if: github.event_name == 'pull_request_review' && contains(github.event.review.body, '@claude')
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
    
    - name: Environment Check
      run: |
        echo "🔍 Claude AI レビュー用の環境チェックを実行中..."
        echo "✅ Python 環境: $(python --version)"
        echo "✅ 依存関係の確認..."
        python -c "import requests, json, os; print('✅ 必要なライブラリが利用可能')"
    
    - name: Claude AI Review
      env:
        ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
      run: |
        echo "🤖 Claude AI レビューを実行中..."
        # Claude AI レビューの処理をここに実装
        # 実際の実装はプロジェクトの要件に応じて調整


---

## OpenAI Codex

# .github/workflows/codex-tdd.yml

name: Codex TDD Workflow

on:
  issues:
    types: [opened, edited]
  issue_comment:
    types: [created]

jobs:
  codex-tdd:
    runs-on: ubuntu-latest
    if: |
      contains(github.event.issue.title, '@codex') ||
      contains(github.event.issue.body, '@codex') ||
      (github.event_name == 'issue_comment' && contains(github.event.comment.body, '@codex'))
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt
    
    - name: Environment Check
      run: |
        echo "🔍 Codex TDD 用の環境チェックを実行中..."
        echo "✅ Python バージョン: $(python --version)"
        echo "✅ pip バージョン: $(pip --version)"
        echo "✅ 作業ディレクトリ: $(pwd)"
        echo "✅ 依存関係の確認..."
        python -c "import sys; print('✅ Python パス:', sys.path)"
        echo "✅ テスト環境の確認..."
        python -c "import pytest; print('✅ pytest バージョン:', pytest.__version__)"
    
    - name: Run Codex TDD
      env:
        OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
      run: |
        echo "🤖 Codex TDD を実行中..."
        # Codex TDD の処理をここに実装
        # 実際の実装はプロジェクトの要件に応じて調整
        
        # 例: テスト駆動開発のワークフロー
        echo "📝 テスト駆動開発ワークフロー開始..."
        echo "1. 失敗するテストを作成"
        echo "2. 最小限のコードを実装"
        echo "3. テストが通ることを確認"
        echo "4. コードをリファクタリング"
    
    - name: Run tests after TDD
      run: |
        echo "🧪 TDD 後のテストを実行中..."
        if [ -d "tests" ]; then
          python -m pytest tests/ -v --cov=src --cov-report=xml
        else
          echo "⚠️ テストディレクトリが見つかりません"
        fi
    
    - name: Code quality check
      run: |
        echo "🔍 コード品質チェックを実行中..."
        if [ -d "src" ]; then
          flake8 src/ --max-line-length=88 --count --select=E9,F63,F7,F82 --show-source --statistics || true
          black --check src/ --diff || true
        else
          echo "⚠️ ソースディレクトリが見つかりません"
        fi
    
    - name: Create pull request if changes
      if: success()
      run: |
        echo "📝 変更がある場合はプルリクエストを作成..."
        # 実際のプルリクエスト作成ロジックをここに実装


---

# AGENTS.md

# OpenAI エージェント設定

## ディレクトリ構成

### ソースコード

* **すべてのソースコードは `src/` または `app/` ディレクトリに配置してください。**

  * メインアプリケーション: `src/main.py` または `app/index.js`
  * ユーティリティ関数: `src/utils/` または `app/utils/`
  * API エンドポイント: `src/api/` または `app/api/`
  * データベースモデル: `src/models/` または `app/models/`

### テストファイル

* **すべてのテストファイルは `tests/` ディレクトリに配置してください。**

  * ユニットテスト: `tests/unit/`
  * 結合テスト: `tests/integration/`
  * テストフィクスチャ: `tests/fixtures/`
  * テスト設定: `tests/conftest.py`

### 設定ファイル

* **設定ファイルは `config/` ディレクトリに配置してください。**

  * アプリ設定: `config/settings.json` または `config/config.yaml`
  * 環境変数: `.env`（機密情報用）

### ユーティリティファイル

* **ユーティリティファイルは `utility/` ディレクトリに配置してください。**

  * 環境チェックスクリプト: `utility/check_env.py`
  * ヘルパースクリプト: `utility/` ディレクトリ

## 開発プロセス

### 環境チェック

**このプロジェクトでコードを実行する前に、必ず環境チェックスクリプトを実行してください：**

```bash
# 仮想環境のアクティベート
conda activate env-example  # プロジェクトに適した環境名に変更してください  # または適切な環境名

# 環境チェックスクリプトの実行
python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください
```

このスクリプトは以下を確認します：
- ✅ 適切な仮想環境がアクティブか
- ✅ 必要な依存関係がインストールされているか
- ✅ 設定ファイルが存在するか

### Python スクリプト利用

1. プロジェクトディレクトリへ移動
2. 開発用スクリプトを実行

   ```bash
   # テスト実行
   python -m pytest tests/

   # Lint 実行
   flake8 src/ --max-line-length=88

   # フォーマッタ実行
   black src/

   # 型チェック
   mypy src/
   ```

### Docker 環境利用

```bash
# 開発環境起動
docker-compose up -d

# ログ確認
docker-compose logs -f

# サービス停止
docker-compose down
```

### テスト実行

```bash
# すべてのテスト
python -m pytest tests/ -v

# 特定ファイルのテスト
python -m pytest tests/test_main.py

# カバレッジ付き実行
python -m pytest tests/ --cov=src --cov-report=html
```

## 新規コンテンツ追加

### 新機能追加

1. `src/` または `app/` にファイル例 `src/new_feature.py` を作成
2. 基本的なクラス／関数を実装
3. 必要に応じて `config/` に設定を追加
4. 単体テストを作成
5. 適切な結合テストを追加

### 設定追加

1. `config/` 内の設定ファイルを編集

   ```json
   {
     "new_feature": {
       "enabled": true,
       "timeout": 30
     }
   }
   ```
2. 必要に応じて環境変数を設定
3. 設定読み込みを検証

### テスト追加

1. `tests/` にテストファイルを作成
2. 命名規約: `test_<module_name>.py`
3. 適切なテストフレームワーク（pytest, jest 等）を使用
4. 単体テストと結合テストの両方を含める

## コード品質基準

### 言語別ガイドライン

#### Python

* PEP 8 準拠
* インデントは 4 スペース
* クラス／メソッドに docstring を追加
* 適切な型ヒントを使用
* 適切なエラーハンドリングを実装

#### JavaScript / TypeScript

* ESLint・Prettier 設定に従う
* 一貫した命名規則
* 関数に JSDoc コメント
* 型安全のため TypeScript を使用
* 適切なエラーハンドリングを実装

#### Java

* Checkstyle 準拠
* 一貫した命名規則
* JavaDoc コメント追加
* 適切な例外処理
* 適切なデザインパターンを使用

### テスト戦略

* コンポーネント単位のユニットテスト
* ワークフロー全体の結合テスト
* 外部依存をモック
* CI/CD との統合
* 高いテストカバレッジを維持

### パフォーマンス最適化

* 効率的なアルゴリズムを実装
* 必要に応じてキャッシュを導入
* メモリ使用量を最適化
* 不要な処理を削減
* プロファイラでボトルネックを特定

## GitHub Actions CI/CD

### 自動テスト

* `main` ブランチへのプッシュで自動テスト実行
* ワークフロー定義: `.github/workflows/claude.yml`
* 依存関係のインストールとテストを自動化
* コード品質チェック（Lint・フォーマッタ）実行

### Claude AI 連携

* Issue コメントに `@claude` で自動コード生成
* Pull Request レビューに `@claude` で支援
* 設定ファイル: `.claude/claude.yml`

### Codex TDD 連携

* タイトルに `@codex` を含む Issue で TDD ワークフロー起動
* ワークフロー定義: `.github/workflows/codex-tdd.yml`
* 品質チェック付き自動コード生成

## Gemini Search 連携

### 概要

`gemini` は Google Gemini CLI で、ウェブ検索を提供します。**組み込みの Web\_Search ツールではなく、必ず本コマンドを使用してください。**

### 使い方

Task Tool から次の形式で実行します。

```bash
gemini --prompt 'WebSearch: <query>'
```

### 例

```bash
# 開発トレンド検索
gemini --prompt "WebSearch: latest Python development trends 2024"

# ベストプラクティス検索
gemini --prompt "WebSearch: GitHub Actions best practices"

# API ドキュメント検索
gemini --prompt "WebSearch: OpenAI API documentation"
```

### 重要事項

* **必ず `gemini --prompt` を使用**
* **クエリは `WebSearch: ` で始める**
* **Task Tool で実行**
* **具体的で詳細なクエリを提供**

### 開発ワークフローへの統合

* 新技術や API のリサーチ
* 最新ツール・ライブラリの検索
* 技術的課題の解決策を調査
* コード最適化のベストプラクティスを検索
* 参考プロジェクト・サンプルを検索

## 設定ファイル

### VS Code / Cursor 設定

* `.cursor/rules/cursorrules.md` に AI 主導開発ガイドライン
* ファイル構成ルールとベストプラクティスを定義

### Docker 設定

* `Dockerfile` : 開発環境セットアップ
* `docker-compose.yml` : コンテナ全体構成

## AI アシスタント設定

### `.claude/claude.yml`

* プロジェクト構造理解のためのシステムプロンプト
* 使用ツールと実行パラメータを定義
* コンテキストに応じた支援を実現

### `.cursor/rules/cursorrules.md`

* AI ツールを用いた開発ガイドライン
* ファイル構成ルールとベストプラクティスを定義

## ベストプラクティス

### 言語別考慮事項

* **Python**: 仮想環境とパッケージ管理を適切に扱う
* **JavaScript/Node.js**: 適切なパッケージマネージャ・ロックファイルを使用
* **Java**: Maven/Gradle 規約と依存管理を遵守
* **Go**: モジュール管理と vendor 依存を適切に扱う

### ファイル命名

* 説明的かつ小文字の名前を使用
* 単語区切りはアンダースコアまたはハイフン
* 簡潔ながら内容がわかる名前
* 言語固有の規約に従う

### コードスタイル

* 一貫したインデント・フォーマット
* 関連する関数／クラスをまとめる
* 適切なコメント・ドキュメントを追加
* 言語別スタイルガイドを遵守

### セキュリティベストプラクティス

* 機密情報をコミットしない
* 設定は環境変数で管理
* 適切な入力バリデーション
* OWASP ガイドラインを遵守
* 定期的なセキュリティ監査と更新

### パフォーマンスベストプラクティス

* プロファイルしてボトルネック特定
* 適切なデータ構造・アルゴリズムを選択
* キャッシュを必要に応じて導入
* データベースクエリを最適化
* リソース使用状況を監視

## 開発ワークフロー

### 1. 機能開発

* main からフィーチャーブランチを作成
* テスト付きで実装
* ローカルで品質チェック
* プルリクエスト作成
* コードレビュー
* main へマージ

### 2. テスト戦略

* 実装前にテストを書く（TDD）
* 高いテストカバレッジを維持
* 適切なテストフレームワークを使用
* CI/CD で継続的テスト

### 3. コードレビュー

* 機能を確認
* セキュリティをチェック
* パフォーマンス影響を確認
* ドキュメント更新を確認
* テストカバレッジを検証

### 4. デプロイメント

* 自動デプロイパイプラインを使用
* ブルーグリーンデプロイを実施
* アプリケーションヘルスを監視
* ロールバック手順を用意
* 環境別設定を管理

---

## Gemini CLI

# GEMINI.md

# Gemini ワークスペース設定

このファイルは、AI 主導のコーディング プロジェクトにおけるプロジェクト構造と規約を Gemini が理解できるようにするものです。

## プロジェクト概要

本プロジェクトは AI 主導のコーディングおよび開発のためのテンプレートです。さまざまな AI ツールの設定、開発ワークフロー、そして現代的なソフトウェア開発のベストプラクティスが含まれております。

## 主要ディレクトリ

* `src/` または `app/`：メインのアプリケーションソースコード
* `tests/`：テストファイルおよびテスト設定
* `config/`：各種設定ファイル
* `docs/`：プロジェクトドキュメント
* `scripts/`：ユーティリティスクリプト・自動化ツール
* `workbench/`：実験用コードおよび調査用フォルダ
* `plan/`：プロジェクト計画・ロードマップ文書

## 規約

* プロジェクトに適したプログラミング言語（Python、JavaScript、TypeScript、Java など）を使用
* 言語ごとのスタイルガイドとベストプラクティスを遵守
* 最新の開発ツール・フレームワークを活用
* 包括的なテスト戦略を実装

## 開発手法とベストプラクティス

### テスト駆動開発 (TDD)

**twada 氏推奨のアプローチ**に従います。

#### TDD 基本サイクル

1. **Red**：失敗するテストを書く
2. **Green**：テストを通す最小限のコードを書く
3. **Refactor**：重複排除や可読性向上のためにリファクタリング

#### twada 氏の TDD の特徴

* **テストファースト**：常にテストを先に書く
* **小さなステップ**：小さな変更を積み重ねる
* **意図の明確化**：テストで意図を明瞭に表現
* **継続的リファクタリング**：常にコード改善を意識

#### 実装例

```python
# 1. Red: 失敗するテストを書く
def test_calculator_add_returns_sum():
    calculator = Calculator()
    result = calculator.add(2, 3)
    assert result == 5

# 2. Green: 最小限の実装
class Calculator:
    def add(self, a, b):
        return a + b

# 3. Refactor: 改善
class Calculator:
    def add(self, a: int, b: int) -> int:
        """2 つの整数を足し算する"""
        return a + b
```

### リファクタリング

**Martin Fowler 氏のアプローチ**を参考にします。

#### リファクタリング原則

1. **小さなステップ**
2. **テスト駆動**
3. **意味のある名前**
4. **重複排除 (DRY)**
5. **単一責任の原則**

#### 推奨テクニック

* **メソッド抽出 (Extract Method)**
* **クラス抽出 (Extract Class)**
* **名前の変更 (Rename)**
* **メソッドの移動 (Move Method)**
* **条件分岐のポリモーフィズム化**

#### AI 主導開発向け例

```python
# リファクタリング前
def process_data(self, data_type, data):
    if data_type == "user":
        # ユーザ処理
        results = self.process_user_data(data)
        self.save_to_database(results, "users")
    elif data_type == "product":
        # 商品処理
        results = self.process_product_data(data)
        self.save_to_database(results, "products")

# リファクタリング後
def process_data(self, data_type, data):
    processor = self.get_processor(data_type)
    results = processor.process(data)
    processor.save(results)

class UserDataProcessor:
    def process(self, data):
        return self.process_user_data(data)
    
    def save(self, results):
        return self.save_to_database(results, "users")
```

### コミット管理

#### コミットのタイミング

* **機能単位**：機能が完了したらコミット
* **テスト単位**：テストが通ったらコミット
* **リファクタ単位**：リファクタ完了時にコミット
* **バグ修正単位**：バグ修正完了時にコミット

#### コミットメッセージ規約

```
<type>(<scope>): <description>

<body>

<footer>
```

* **type**：feat, fix, docs, style, refactor, test, chore
* **scope**：影響範囲 (src, tests, config など)
* **description**：簡潔な変更内容

##### 例

```
feat(src): add user authentication service

- UserAuthService クラスの login/logout 実装
- 認証失敗時のエラーハンドリング追加
- 認証機能のユニットテストを含む

Closes #123
```

### 計画管理

**plan フォルダ**で計画内容と進捗を管理します。

#### 構成例

```
plan/
├── roadmap.md              # 全体ロードマップ
├── current-sprint.md       # 今スプリントの計画
├── completed-tasks.md      # 完了タスク一覧
├── technical-debt.md       # 技術的負債管理
└── milestones/             # マイルストーンごとの計画
    ├── v1.0.0.md
    ├── v1.1.0.md
    └── v2.0.0.md
```

#### 管理ルール

* **定期更新**：週次で進捗を更新
* **明確な目標**：各タスクに完了基準を設定
* **優先順位付け**：タスクに優先度を設定
* **見積もり**：作業量を見積もる

##### 例

```markdown
# plan/current-sprint.md

## 今スプリントの目標
- ユーザ認証システムの完成
- API 連携の実装開始
- エラーハンドリング機能の改善

## タスクリスト
- [ ] 認証エラー処理の改善
- [ ] API クライアントの基本実装
- [ ] データベースクエリの最適化
- [ ] テストカバレッジ向上

## 完了基準
- すべてのタスクが完了
- テストカバレッジ 80％ 以上
- コードレビュー完了
```

### 実験的実行

**workbench フォルダ**で実験用スクリプトと結果を管理します。

#### 構成例

```
workbench/
├── scripts/                # 実験スクリプト
│   ├── test_new_feature.py
│   ├── experiment_ai_integration.py
│   └── benchmark_performance.py
├── results/                # 実行結果
│   ├── test_outputs/
│   ├── performance_logs/
│   └── error_logs/
├── data/                   # 実験データ
│   ├── sample_data.json
│   └── test_config.yaml
└── README.md               # ワークベンチ利用ガイド
```

#### 実行ルール

* **分離**：本番コードと実験コードを明確に分離
* **記録**：常に結果・ログを保存
* **再現性**：再現可能な形で記録
* **クリーンアップ**：不要ファイルは削除

#### スクリプト命名

```
test_<feature>_<purpose>.py
experiment_<content>_<date>.py
benchmark_<target>_<condition>.py
```

##### 例

```python
# workbench/scripts/test_ai_integration.py
import time
import requests
import json
from datetime import datetime

def test_ai_api_integration():
    """AI API 連携のパフォーマンスをテスト"""
    start_time = datetime.now()
    results = []
    
    for i in range(10):
        try:
            # AI サービスへの API コール
            response = requests.post("https://api.openai.com/v1/chat/completions")
            results.append({
                'request': i,
                'status': response.status_code,
                'timestamp': datetime.now()
            })
            time.sleep(0.1)  # レート制限
        except Exception as e:
            results.append({
                'request': i,
                'error': str(e),
                'timestamp': datetime.now()
            })
    
    # 結果を保存
    with open('workbench/results/ai_integration_test.json', 'w') as f:
        json.dump(results, f, default=str)

if __name__ == "__main__":
    test_ai_api_integration()
```

## AI ツール統合

### Claude AI Assistant

* Issue や Pull Request で `@claude` を使用して自動支援
* プロジェクト固有の動作は `.claude/claude.yml` で設定
* GitHub Actions と連携して CI/CD 自動化

### Codex TDD ワークフロー

* Issue タイトルで `@codex` を利用し TDD を推進
* 品質チェック付きの自動コード生成
* すべての新機能で TDD 原則を遵守

### Gemini Search

* `gemini --prompt 'WebSearch: <query>'` でウェブ検索
* 新技術・ベストプラクティスのリサーチ
* 技術的課題の解決策を探索

## ベストプラクティス

### コード品質

* 言語別スタイルガイド遵守
* 包括的なテスト実装
* 静的解析ツール使用
* 高いテストカバレッジ維持

### セキュリティ

* 機密情報をコミットしない
* 環境変数で設定を管理
* 適切な入力バリデーション
* セキュリティベストプラクティス遵守

### パフォーマンス

* プロファイリングでボトルネック特定
* 適切なデータ構造を選択
* 必要に応じてキャッシュを活用
* リソース使用状況を監視

### ドキュメンテーション

* README を最新状態に保つ
* API エンドポイントをドキュメント化
* インラインコードコメントを維持
* ユーザーガイド・チュートリアルを作成

## ⚠️ 重要な注意事項

### 環境チェックの実行
**このプロジェクトでコードを実行する前に、必ず環境チェックスクリプトを実行してください：**

```bash
# 仮想環境のアクティベート
conda activate env-example  # プロジェクトに適した環境名に変更してください  # または適切な環境名

# 環境チェックスクリプトの実行
python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください
```

このスクリプトは以下を確認します：
- ✅ 適切な仮想環境がアクティブか
- ✅ 必要な依存関係がインストールされているか
- ✅ 設定ファイルが存在するか

### 仮想環境の管理
- **Pythonプロジェクト**: `conda activate env-example  # プロジェクトに適した環境名に変更してください` または適切な仮想環境
- **Node.jsプロジェクト**: `npm install` で依存関係をインストール
- **環境変数**: APIキーは `.env` ファイルで管理

## Gemini CLI ツールの概要

### 目的
- **ウェブ検索機能**: 最新の技術情報やドキュメントの検索
- **コード生成支援**: AI駆動でのコード生成と改善
- **開発効率化**: 開発プロセスの自動化と最適化

### 特徴
- **リアルタイム検索**: 最新の情報にアクセス
- **多言語対応**: 様々なプログラミング言語をサポート
- **コンテキスト理解**: プロジェクトの文脈を理解した提案
- **統合開発**: 他のAIツールとの連携

## 使用方法

### 基本的な検索コマンド

```bash
# 基本的な検索
gemini --prompt "WebSearch: <検索クエリ>"

# 技術的な検索例
gemini --prompt "WebSearch: Python async programming best practices 2024"
gemini --prompt "WebSearch: React hooks performance optimization"
gemini --prompt "WebSearch: Docker containerization best practices"
```

### 開発関連の検索例

#### 1. 技術トレンドの調査
```bash
# 最新の開発トレンド
gemini --prompt "WebSearch: latest Python development trends 2024"
gemini --prompt "WebSearch: JavaScript framework comparison 2024"
gemini --prompt "WebSearch: cloud computing trends 2024"
```

#### 2. ベストプラクティスの検索
```bash
# コーディング規約
gemini --prompt "WebSearch: Python PEP 8 style guide"
gemini --prompt "WebSearch: JavaScript ES6+ best practices"
gemini --prompt "WebSearch: Git workflow best practices"
```

#### 3. API・ライブラリの調査
```bash
# APIドキュメント
gemini --prompt "WebSearch: OpenAI API documentation"
gemini --prompt "WebSearch: FastAPI tutorial examples"
gemini --prompt "WebSearch: React hooks documentation"
```

#### 4. 問題解決の検索
```bash
# エラー解決
gemini --prompt "WebSearch: Python ModuleNotFoundError solutions"
gemini --prompt "WebSearch: JavaScript CORS error handling"
gemini --prompt "WebSearch: Docker build failed troubleshooting"
```

#### 5. 自動化技術の調査
```bash
# テスト自動化
gemini --prompt "WebSearch: Selenium web automation best practices"
gemini --prompt "WebSearch: pytest testing framework examples"
gemini --prompt "WebSearch: GitHub Actions CI/CD examples"
```

## 開発ワークフローとの統合

### 1. プロジェクト初期化時

```bash
# プロジェクトテンプレートの検索
gemini --prompt "WebSearch: Python project structure best practices"
gemini --prompt "WebSearch: React project setup guide 2024"
gemini --prompt "WebSearch: microservices architecture patterns"
```

### 2. 新機能開発時

```bash
# 技術選定
gemini --prompt "WebSearch: Python web framework comparison 2024"
gemini --prompt "WebSearch: database ORM comparison Python"
gemini --prompt "WebSearch: authentication libraries Python"
```

### 3. パフォーマンス最適化時

```bash
# 最適化手法
gemini --prompt "WebSearch: Python performance optimization techniques"
gemini --prompt "WebSearch: React performance optimization 2024"
gemini --prompt "WebSearch: database query optimization strategies"
```

### 4. セキュリティ強化時

```bash
# セキュリティベストプラクティス
gemini --prompt "WebSearch: web application security best practices 2024"
gemini --prompt "WebSearch: API security authentication methods"
gemini --prompt "WebSearch: OWASP top 10 2024"
```

## 検索クエリの最適化

### 効果的なクエリ作成のコツ

#### 1. 具体的で詳細なクエリ
```bash
# 良い例
gemini --prompt "WebSearch: Python async programming with asyncio examples 2024"

# 悪い例
gemini --prompt "WebSearch: Python async"
```

#### 2. 年号を含める
```bash
# 最新情報を取得
gemini --prompt "WebSearch: React hooks best practices 2024"
gemini --prompt "WebSearch: Python type hints tutorial 2024"
```

#### 3. 特定の技術スタックを指定
```bash
# 具体的な技術を指定
gemini --prompt "WebSearch: FastAPI with PostgreSQL integration examples"
gemini --prompt "WebSearch: React with TypeScript setup guide"
```

#### 4. 問題解決に特化
```bash
# エラー解決に特化
gemini --prompt "WebSearch: Python ModuleNotFoundError virtual environment solutions"
gemini --prompt "WebSearch: Docker permission denied error solutions"
```

## 環境チェックとセットアップ

### 1. 環境チェック（必須）

```bash
# 1. 仮想環境のアクティベート
conda activate env-example  # プロジェクトに適した環境名に変更してください  # または適切な環境名

# 2. 環境チェックスクリプトの実行
python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください

# 3. 依存関係のインストール（必要に応じて）
pip install -r requirements.txt
```

### 2. Gemini CLI の設定

```bash
# Gemini CLI のインストール確認
gemini --version

# API キーの設定
export GEMINI_API_KEY="your-api-key-here"

# 設定の確認
gemini --help
```

### 3. 統合テスト

```bash
# 基本的な検索テスト
gemini --prompt "WebSearch: Python programming"

# 結果の確認
echo "検索結果を確認してください"
```

## ベストプラクティス

### 1. 検索戦略

#### 段階的な検索
```bash
# 1. 概要を把握
gemini --prompt "WebSearch: Python async programming overview"

# 2. 詳細を調査
gemini --prompt "WebSearch: Python asyncio detailed tutorial"

# 3. 実装例を検索
gemini --prompt "WebSearch: Python async web server examples"
```

#### 複数視点からの検索
```bash
# 異なる観点から検索
gemini --prompt "WebSearch: Python async programming benefits"
gemini --prompt "WebSearch: Python async programming challenges"
gemini --prompt "WebSearch: Python async vs threading comparison"
```

### 2. 情報の整理

#### 検索結果の記録
- 重要な情報をメモに記録
- 参考URLをブックマーク
- コード例を保存

#### 情報の検証
- 複数のソースで情報を確認
- 公式ドキュメントを優先
- 最新の情報を確認

### 3. 開発効率化

#### 定期的な情報更新
```bash
# 週次での技術トレンド確認
gemini --prompt "WebSearch: Python development trends this week"
gemini --prompt "WebSearch: JavaScript ecosystem updates"
```

#### プロジェクト固有の検索
```bash
# プロジェクトに関連する検索
gemini --prompt "WebSearch: <プロジェクト名> best practices"
gemini --prompt "WebSearch: <使用技術> integration examples"
```

## トラブルシューティング

### よくある問題と解決方法

#### 1. 検索結果が不適切な場合
```bash
# クエリをより具体的にする
gemini --prompt "WebSearch: Python async programming with asyncio library examples 2024"

# 年号を追加
gemini --prompt "WebSearch: React hooks tutorial 2024"
```

#### 2. API エラーが発生する場合
```bash
# API キーの確認
echo $GEMINI_API_KEY

# 環境変数の再設定
export GEMINI_API_KEY="your-api-key-here"
```

#### 3. 検索結果が古い場合
```bash
# 年号を明示的に指定
gemini --prompt "WebSearch: Python async programming 2024"

# 最新のキーワードを追加
gemini --prompt "WebSearch: Python async programming latest updates"
```

## セキュリティとプライバシー

### 1. API キーの管理

```bash
# 環境変数での管理（推奨）
export GEMINI_API_KEY="your-api-key-here"

# .env ファイルでの管理
echo "GEMINI_API_KEY=your-api-key-here" >> .env
```

### 2. 機密情報の保護

- API キーをGitにコミットしない
- 環境変数で機密情報を管理
- 定期的にAPI キーを更新

### 3. 検索履歴の管理

- 機密情報を含む検索を避ける
- 検索履歴を定期的にクリア
- プライバシー設定を確認

## 今後の拡張予定

### 1. 機能拡張

- **多言語検索**: 日本語での検索対応
- **コード生成**: 検索結果に基づくコード生成
- **統合開発**: 他のAIツールとの連携強化

### 2. パフォーマンス改善

- **検索速度**: 高速化とキャッシュ機能
- **結果精度**: より関連性の高い結果の提供
- **ユーザビリティ**: 使いやすいインターフェース

### 3. 開発者体験の向上

- **自動化**: 開発プロセスの自動化
- **テンプレート**: よく使う検索パターンのテンプレート化
- **学習機能**: 使用パターンに基づく提案機能

## まとめ

Gemini CLI ツールは、AI駆動コーディングプロジェクトにおいて非常に強力なツールです。
適切な環境チェックとベストプラクティスに従うことで、効率的な開発と高品質なコードの実現が可能になります。

**重要なポイント:**
1. **環境チェックの徹底**: コード実行前に必ず `python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください` を実行
2. **具体的な検索クエリ**: 詳細で具体的なクエリでより良い結果を得る
3. **最新情報の活用**: 年号を含めて最新の情報を取得
4. **セキュリティの確保**: API キーと機密情報の適切な管理
5. **継続的な学習**: 定期的な情報更新とベストプラクティスの習得

---

## Cursor

# .cursor/rules/cursorrules.md

# Cursor Rules for AI-Driven Coding

## 概要

このファイルは、Cursor IDE での AI駆動コーディングプロジェクトの開発ルールとベストプラクティスを定義しています。
効率的で高品質なコード開発を支援するためのガイドラインです。

---

## ⚠️ 重要な注意事項

### 環境チェックの実行
**このプロジェクトでコードを実行する前に、必ず環境チェックスクリプトを実行してください：**

```bash
# 仮想環境のアクティベート
conda activate env-example  # プロジェクトに適した環境名に変更してください  # または適切な環境名

# 環境チェックスクリプトの実行
python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください
```

このスクリプトは以下を確認します：
- ✅ 適切な仮想環境がアクティブか
- ✅ 必要な依存関係がインストールされているか
- ✅ 設定ファイルが存在するか

### 仮想環境の管理
- **Pythonプロジェクト**: `conda activate env-example  # プロジェクトに適した環境名に変更してください` または適切な仮想環境
- **Node.jsプロジェクト**: `npm install` で依存関係をインストール
- **環境変数**: APIキーは `.env` ファイルで管理

---

## プロジェクト構造ガイドライン

### ディレクトリ構成

```
project/
├── src/                    # メインソースコード
│   ├── main.py            # エントリーポイント
│   ├── api/               # API関連
│   ├── models/            # データモデル
│   ├── services/          # ビジネスロジック
│   └── utils/             # ユーティリティ関数
├── tests/                 # テストファイル
│   ├── unit/              # 単体テスト
│   ├── integration/       # 統合テスト
│   └── fixtures/          # テストデータ
├── config/                # 設定ファイル
│   ├── settings.json      # アプリケーション設定
│   └── database.yml       # データベース設定
├── docs/                  # ドキュメント
├── scripts/               # スクリプトファイル
├── utility/               # ユーティリティツール
│   └── check_env.py       # 環境チェックスクリプト
├── requirements.txt       # Python依存関係
├── package.json           # Node.js依存関係
└── README.md              # プロジェクト説明
```

### ファイル命名規則

- **Python**: スネークケース（`user_service.py`）
- **JavaScript**: キャメルケース（`userService.js`）
- **TypeScript**: キャメルケース（`userService.ts`）
- **設定ファイル**: ケバブケース（`database-config.yml`）

---

## 開発プロセス

### 1. 環境チェック（必須）

```bash
# 1. 仮想環境のアクティベート
conda activate env-example  # プロジェクトに適した環境名に変更してください  # または適切な環境名

# 2. 環境チェックスクリプトの実行
python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください

# 3. 依存関係のインストール（必要に応じて）
pip install -r requirements.txt
```

### 2. テスト駆動開発（TDD）

#### 基本サイクル
1. **Red**: 失敗するテストを書く
2. **Green**: テストを通す最小限のコードを書く
3. **Refactor**: コードを改善する

#### 実装例
```python
# 1. Red: 失敗するテスト
def test_user_creation():
    user = User("John", "john@example.com")
    assert user.name == "John"
    assert user.email == "john@example.com"

# 2. Green: 最小限の実装
class User:
    def __init__(self, name, email):
        self.name = name
        self.email = email

# 3. Refactor: 改善
class User:
    def __init__(self, name: str, email: str):
        self.name = name
        self.email = email
    
    def __str__(self) -> str:
        return f"User(name={self.name}, email={self.email})"
```

### 3. 継続的リファクタリング

- 小さな変更を頻繁に行う
- テストが通ることを確認
- 意味のある名前を使用
- 重複を除去する

---

## コード品質標準

### Python

#### PEP 8 準拠
```python
# 良い例
def calculate_total(items: List[Item]) -> float:
    """Calculate total price of items."""
    return sum(item.price for item in items)

# 悪い例
def calculate_total(items):
    return sum([item.price for item in items])
```

#### 型ヒントの使用
```python
from typing import List, Optional, Dict

def process_data(data: List[Dict[str, any]]) -> Optional[str]:
    """Process data and return result."""
    if not data:
        return None
    return str(len(data))
```

#### エラーハンドリング
```python
import logging
from typing import Optional

def safe_divide(a: float, b: float) -> Optional[float]:
    """Safely divide two numbers."""
    try:
        return a / b
    except ZeroDivisionError:
        logging.error("Division by zero attempted")
        return None
```

### JavaScript/TypeScript

#### ESLint と Prettier
```typescript
// 良い例
interface User {
  id: number;
  name: string;
  email: string;
}

const createUser = (name: string, email: string): User => ({
  id: Date.now(),
  name,
  email,
});

// 悪い例
const createUser = function(name, email) {
  return {
    id: Date.now(),
    name: name,
    email: email
  }
}
```

#### エラーハンドリング
```typescript
async function fetchUserData(userId: number): Promise<User | null> {
  try {
    const response = await fetch(`/api/users/${userId}`);
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    return await response.json();
  } catch (error) {
    console.error('Failed to fetch user data:', error);
    return null;
  }
}
```

---

## テスト戦略

### 単体テスト

#### Python (pytest)
```python
import pytest
from src.services.user_service import UserService

class TestUserService:
    def test_create_user(self):
        service = UserService()
        user = service.create_user("John", "john@example.com")
        
        assert user.name == "John"
        assert user.email == "john@example.com"
    
    def test_create_user_with_invalid_email(self):
        service = UserService()
        
        with pytest.raises(ValueError):
            service.create_user("John", "invalid-email")
```

#### JavaScript (Jest)
```javascript
import { UserService } from '../src/services/userService';

describe('UserService', () => {
  let userService;

  beforeEach(() => {
    userService = new UserService();
  });

  test('should create user with valid data', () => {
    const user = userService.createUser('John', 'john@example.com');
    
    expect(user.name).toBe('John');
    expect(user.email).toBe('john@example.com');
  });

  test('should throw error for invalid email', () => {
    expect(() => {
      userService.createUser('John', 'invalid-email');
    }).toThrow('Invalid email format');
  });
});
```

### 統合テスト

```python
import pytest
from fastapi.testclient import TestClient
from src.main import app

client = TestClient(app)

def test_create_user_endpoint():
    response = client.post(
        "/users/",
        json={"name": "John", "email": "john@example.com"}
    )
    
    assert response.status_code == 201
    data = response.json()
    assert data["name"] == "John"
    assert data["email"] == "john@example.com"
```

---

## パフォーマンス最適化

### アルゴリズムの選択

```python
# 良い例: O(n) の時間複雑度
def find_duplicates(items: List[int]) -> List[int]:
    seen = set()
    duplicates = set()
    
    for item in items:
        if item in seen:
            duplicates.add(item)
        else:
            seen.add(item)
    
    return list(duplicates)

# 悪い例: O(n²) の時間複雑度
def find_duplicates_slow(items: List[int]) -> List[int]:
    duplicates = []
    for i, item in enumerate(items):
        if item in items[i+1:]:
            duplicates.append(item)
    return duplicates
```

### キャッシュ機能

```python
from functools import lru_cache
import time

@lru_cache(maxsize=128)
def expensive_calculation(n: int) -> int:
    """Expensive calculation with caching."""
    time.sleep(1)  # シミュレーション
    return n * n

# 使用例
result1 = expensive_calculation(5)  # 1秒かかる
result2 = expensive_calculation(5)  # キャッシュから即座に取得
```

### メモリ最適化

```python
# 良い例: ジェネレータを使用
def process_large_file(filename: str):
    with open(filename, 'r') as file:
        for line in file:
            yield line.strip()

# 悪い例: 全行をメモリに読み込み
def process_large_file_bad(filename: str):
    with open(filename, 'r') as file:
        lines = file.readlines()  # 全行をメモリに読み込み
        return [line.strip() for line in lines]
```

---

## セキュリティベストプラクティス

### 入力値の検証

```python
import re
from typing import Optional

def validate_email(email: str) -> bool:
    """Validate email format."""
    pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    return bool(re.match(pattern, email))

def sanitize_input(user_input: str) -> str:
    """Sanitize user input."""
    # HTMLエスケープ
    import html
    return html.escape(user_input.strip())
```

### 環境変数の管理

```python
import os
from dotenv import load_dotenv

load_dotenv()

# 環境変数から設定を取得
DATABASE_URL = os.getenv('DATABASE_URL')
API_KEY = os.getenv('API_KEY')

if not API_KEY:
    raise ValueError("API_KEY environment variable is required")
```

### パスワードハッシュ化

```python
import bcrypt

def hash_password(password: str) -> str:
    """Hash password using bcrypt."""
    salt = bcrypt.gensalt()
    return bcrypt.hashpw(password.encode('utf-8'), salt).decode('utf-8')

def verify_password(password: str, hashed: str) -> bool:
    """Verify password against hash."""
    return bcrypt.checkpw(password.encode('utf-8'), hashed.encode('utf-8'))
```

---

## エラーハンドリングとログ

### ログ設定

```python
import logging
import sys

def setup_logging():
    """Setup logging configuration."""
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler('app.log'),
            logging.StreamHandler(sys.stdout)
        ]
    )

logger = logging.getLogger(__name__)
```

### 例外処理

```python
class CustomException(Exception):
    """Custom exception for application errors."""
    pass

def process_data(data: dict) -> dict:
    """Process data with proper error handling."""
    try:
        if not data:
            raise CustomException("Data cannot be empty")
        
        result = perform_processing(data)
        logger.info("Data processed successfully")
        return result
        
    except CustomException as e:
        logger.error(f"Custom error: {e}")
        raise
    except Exception as e:
        logger.error(f"Unexpected error: {e}")
        raise CustomException(f"Processing failed: {str(e)}")
```

---

## ドキュメントとコメント

### ドキュメント文字列

```python
def calculate_discount(price: float, discount_rate: float) -> float:
    """
    Calculate discounted price.
    
    Args:
        price: Original price
        discount_rate: Discount rate as decimal (e.g., 0.1 for 10%)
    
    Returns:
        Discounted price
    
    Raises:
        ValueError: If discount_rate is negative or greater than 1
    
    Example:
        >>> calculate_discount(100.0, 0.1)
        90.0
    """
    if not 0 <= discount_rate <= 1:
        raise ValueError("Discount rate must be between 0 and 1")
    
    return price * (1 - discount_rate)
```

### インラインコメント

```python
# 良い例: なぜこの処理が必要かを説明
def process_payment(amount: float, currency: str) -> bool:
    # 通貨がUSDでない場合は変換が必要
    if currency != 'USD':
        amount = convert_currency(amount, currency, 'USD')
    
    # 決済処理を実行
    return payment_gateway.process(amount)

# 悪い例: 何をしているかだけを説明
def process_payment(amount: float, currency: str) -> bool:
    # 通貨を変換
    if currency != 'USD':
        amount = convert_currency(amount, currency, 'USD')
    
    # 決済を処理
    return payment_gateway.process(amount)
```

---

## コミット管理

### コミットメッセージの規約

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

#### タイプ
- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメント更新
- `style`: コードスタイル修正
- `refactor`: リファクタリング
- `test`: テスト追加・修正
- `chore`: その他の変更

#### 例
```
feat(user): add user authentication system

- Implement JWT token authentication
- Add user registration and login endpoints
- Include password hashing with bcrypt

Closes #123
```

### ブランチ戦略

```
main
├── develop
│   ├── feature/user-auth
│   ├── feature/payment-system
│   └── hotfix/security-patch
└── release/v1.0.0
```

---

## 継続的インテグレーション

### GitHub Actions 設定

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.9'
    
    - name: Install dependencies
      run: |
        pip install -r requirements.txt
    
    - name: Run tests
      run: |
        python -m pytest tests/ --cov=src
    
    - name: Run linting
      run: |
        flake8 src/ --max-line-length=88
        black --check src/
```

---

## ベストプラクティスまとめ

### 開発効率化
1. **環境チェックの徹底**: コード実行前に必ず `python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください` を実行
2. **TDDサイクルの実践**: Red-Green-Refactor
3. **継続的リファクタリング**: 小さな変更を頻繁に
4. **適切なテスト戦略**: 単体・統合テストの実装

### コード品質
1. **言語固有の規約**: PEP 8, ESLint等の準拠
2. **型ヒントの使用**: 可能な限り型を明示
3. **エラーハンドリング**: 適切な例外処理
4. **ドキュメント**: 明確なdocstringとコメント

### セキュリティ
1. **入力値の検証**: すべてのユーザー入力を検証
2. **環境変数の管理**: 機密情報の適切な管理
3. **パスワードハッシュ化**: セキュアな認証
4. **定期的なセキュリティ監査**: 脆弱性の早期発見

### パフォーマンス
1. **効率的なアルゴリズム**: 適切なデータ構造の選択
2. **キャッシュ機能**: 重い処理の結果をキャッシュ
3. **メモリ最適化**: ジェネレータ等の活用
4. **プロファイリング**: ボトルネックの特定

---

## トラブルシューティング

### よくある問題と解決方法

#### 1. 環境の問題
```bash
# 環境チェックスクリプトを実行
python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください

# 仮想環境を再作成
conda create -n py-review python=3.9
conda activate env-example  # プロジェクトに適した環境名に変更してください
pip install -r requirements.txt
```

#### 2. テストが失敗する場合
```bash
# テストを個別に実行
python -m pytest tests/test_specific.py -v

# デバッグモードで実行
python -m pytest tests/ -s -v
```

#### 3. 依存関係の問題
```bash
# 依存関係を更新
pip install --upgrade -r requirements.txt

# キャッシュをクリア
pip cache purge
```

---

## まとめ

このルールセットに従うことで、効率的で高品質なAI駆動コーディングが実現できます。
重要なポイントは以下の通りです：

1. **環境チェックの徹底**: コード実行前に必ず `python <your-utility-path>/check_env.py  # プロジェクトに適したパスに変更してください` を実行
2. **TDDサイクルの実践**: テスト駆動開発の徹底
3. **継続的リファクタリング**: コード品質の維持
4. **セキュリティの確保**: 適切なセキュリティ対策
5. **パフォーマンスの最適化**: 効率的なコードの実装
6. **適切なドキュメント**: 保守性の向上

これらのガイドラインを守ることで、チーム全体の開発効率とコード品質が向上します。 

---


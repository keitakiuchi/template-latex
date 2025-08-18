# AI-Driven Coding Rules for Cursor

## 概要

このファイルは、jpr-llm-evaluationリポジトリで使用するAI駆動コーディングのルールとベストプラクティスを定義しています。
効率的で高品質なコード開発を支援するためのガイドラインです。

## 🚀 自動スタート機能

ユーザーが「スタート」と入力した場合、AIアシスタントは自動的に以下のコマンドを実行します：

```bash
python utility/start.py
```

このコマンドにより、以下の処理が自動的に実行されます：
1. **仮想環境の自動アクティベート**: `py-latex`環境が自動的にアクティベートされます
2. **環境チェックの実行**: 開発環境が適切に設定されているかを確認します
3. **次のステップの案内**: 開発開始のためのガイダンスを提供します

### 仮想環境の自動管理
- スタート時に`py-latex`環境が存在しない場合は作成方法を案内
- 既にアクティブな場合はそのまま継続
- 非アクティブな場合は自動的にアクティベート
- 今後のセッションでの仮想環境アクティベート方法も案内

## 生成日時
2025-07-02 14:46:17

## 対応AIツール
- **Claude Code CLI**: コード生成・改善・レビュー
- **Claude Code GitHub Actions**: CI/CD統合
- **OpenAI Codex**: コード補完・生成
- **Gemini CLI**: ウェブ検索・技術情報取得
- **Cursor**: AI統合開発環境

---

## ⚠️ 重要な注意事項

### 環境チェックの実行
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

#### 方法1: スタートスクリプトを使用（推奨）
```bash
# Pythonスクリプト版（推奨）- 仮想環境自動アクティベート機能付き
python utility/start.py

# シェルスクリプト版 - 仮想環境自動アクティベート機能付き
./utility/start.sh
```

#### 方法2: ワンライナー
```bash
# スタートコマンドの実行
python -c "import sys; sys.path.append('utility'); from start import main; main()"
```

#### 方法3: 直接実行
```bash
# プロジェクトルートで実行
echo "スタート" | python -c "
import sys
sys.path.append('utility')
from start import main
main()
"
```

### 仮想環境の管理
- **Pythonプロジェクト**: `conda activate py-latex` または適切な仮想環境
- **Node.jsプロジェクト**: `npm install` で依存関係をインストール
- **環境変数**: APIキーは `.env` ファイルで管理

### 自動仮想環境アクティベート
AIアシスタントが処理を実行する際は、常に以下の手順を確認します：

1. **仮想環境の確認**: 現在の環境が`py-latex`かどうかを確認
2. **自動アクティベート**: 非アクティブな場合は`conda activate py-latex`を実行
3. **環境チェック**: 必要に応じて`python utility/check_env.py`を実行
4. **処理実行**: 仮想環境が確実にアクティブな状態で処理を実行

これにより、すべての処理が適切な仮想環境で実行されます。

---

## プロジェクト構造ガイドライン

### ディレクトリ構成

```
jpr-llm-evaluation/
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
│   ├── check_env.py       # 環境チェックスクリプト
│   ├── start.py           # スタートスクリプト（Python版）
│   └── start.sh           # スタートスクリプト（シェル版）
├── tex/                   # LaTeXソースファイル
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
conda activate py-latex  # または適切な環境名

# 2. 環境チェックスクリプトの実行
python utility/check_env.py

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

## AIツールの使用方法

### Claude AI アシスタント
```bash
# GitHub Issuesで@claudeをメンション
# プルリクエストレビューで@claudeをメンション
```

### Gemini CLI 検索
```bash
# 技術情報の検索
gemini --prompt "WebSearch: Python async programming best practices 2024"

# APIドキュメントの検索
gemini --prompt "WebSearch: OpenAI API documentation"

# ベストプラクティスの検索
gemini --prompt "WebSearch: GitHub Actions best practices"
```

### Cursor IDE
- `.cursor/rules/` ディレクトリのルールファイルを参照
- AI駆動開発のベストプラクティスに従った開発

---

## テスト戦略

### 単体テスト
- 各関数・メソッドの動作を個別にテスト
- モックを使用して外部依存を分離
- エッジケースをカバー

### 統合テスト
- 複数のコンポーネント間の連携をテスト
- データベースやAPIとの統合をテスト

### エンドツーエンドテスト
- ユーザーシナリオに基づくテスト
- 実際のブラウザ環境でのテスト

---

## セキュリティベストプラクティス

### 入力検証
- すべてのユーザー入力を検証
- SQLインジェクション対策
- XSS攻撃対策

### 認証・認可
- 適切な認証メカニズムの実装
- 最小権限の原則に従う
- セッション管理の適切な実装

### 機密情報の管理
- APIキーは環境変数で管理
- パスワードはハッシュ化
- ログに機密情報を含めない

---

## パフォーマンス最適化

### データベース最適化
- 適切なインデックスの作成
- N+1問題の回避
- クエリの最適化

### キャッシュ戦略
- 適切なキャッシュの実装
- キャッシュの有効期限管理
- キャッシュの無効化戦略

### 非同期処理
- 長時間実行される処理は非同期化
- 適切なエラーハンドリング
- リソースの適切な管理

---

## ドキュメントとコメント

### コードコメント
- 複雑なロジックには適切なコメント
- 関数・クラスにはdocstring
- 変更履歴の記録

### APIドキュメント
- OpenAPI/Swaggerの使用
- エンドポイントの詳細な説明
- リクエスト・レスポンス例

### ユーザードキュメント
- セットアップ手順
- 使用方法
- トラブルシューティング

---

## コミット管理

### コミットメッセージの規約
```
<type>(<scope>): <subject>

<body>

<footer>
```

#### タイプ
- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメント
- `style`: コードスタイル
- `refactor`: リファクタリング
- `test`: テスト
- `chore`: その他

### ブランチ戦略
- `main`: 本番環境
- `develop`: 開発環境
- `feature/*`: 機能開発
- `hotfix/*`: 緊急修正

---

## 継続的インテグレーション

### GitHub Actions
- 自動テスト実行
- コード品質チェック
- 自動デプロイ

### コードレビュー
- プルリクエストでのレビュー
- 自動化されたチェック
- 手動レビューの実施

---

## トラブルシューティング

### よくある問題と解決方法

#### 環境関連
- 仮想環境がアクティブでない
- 依存関係の不足
- パスの設定ミス

#### コード関連
- インポートエラー
- 型エラー
- ランタイムエラー

#### パフォーマンス関連
- メモリリーク
- 遅いクエリ
- 非効率なアルゴリズム

---

## まとめ

このルールファイルは、jpr-llm-evaluationプロジェクトでのAI駆動コーディングのベストプラクティスを定義しています。
開発者はこれらのガイドラインに従って、高品質で保守性の高いコードを作成してください。

### 重要なポイント
1. **環境チェックの実行**: 開発開始前に必ず環境チェックを実行
2. **テスト駆動開発**: TDDサイクルに従った開発
3. **コード品質**: PEP 8、ESLint等の規約に従う
4. **セキュリティ**: セキュリティベストプラクティスの遵守
5. **ドキュメント**: 適切なドキュメントとコメントの作成
6. **継続的改善**: 定期的なリファクタリングと改善 
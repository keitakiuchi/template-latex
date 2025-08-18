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
conda activate py-latex  # プロジェクトに適した環境名に変更してください

# 環境チェックスクリプトの実行
python utility/check_env.py  # プロジェクトに適したパスに変更してください
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

### 仮想環境の管理
- **Pythonプロジェクト**: `conda activate py-latex` または適切な仮想環境
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
gemini --prompt "WebSearch: LaTeX project organization best practices"
```

### 2. 開発中の技術調査

```bash
# 新しい技術の調査
gemini --prompt "WebSearch: latest LaTeX packages for academic writing"
gemini --prompt "WebSearch: Python data analysis libraries 2024"
```

### 3. 問題解決時

```bash
# エラーの解決
gemini --prompt "WebSearch: LaTeX compilation errors solutions"
gemini --prompt "WebSearch: Python virtual environment issues"
```

---

## 検索クエリの最適化

### 効果的な検索のコツ

#### 1. 具体的なキーワードを使用
```bash
# 良い例
gemini --prompt "WebSearch: Python type hints best practices 2024"

# 悪い例
gemini --prompt "WebSearch: Python"
```

#### 2. 年号を含める
```bash
# 最新情報の取得
gemini --prompt "WebSearch: React hooks tutorial 2024"
gemini --prompt "WebSearch: Python async await examples 2024"
```

#### 3. エラーメッセージを含める
```bash
# エラー解決
gemini --prompt "WebSearch: 'ModuleNotFoundError: No module named' Python solution"
```

---

## 環境チェックとセットアップ

### 前提条件
- Gemini CLI がインストールされている
- APIキーが設定されている
- インターネット接続が利用可能

### セットアップ手順
```bash
# 1. Gemini CLI のインストール
pip install google-generativeai

# 2. APIキーの設定
export GEMINI_API_KEY="your-api-key-here"

# 3. 動作確認
gemini --prompt "WebSearch: Python version 3.12 features"
```

---

## ベストプラクティス

### 1. 検索クエリの設計
- 具体的で明確なキーワードを使用
- 年号やバージョン番号を含める
- エラーメッセージは正確にコピー

### 2. 結果の活用
- 複数のソースを比較
- 公式ドキュメントを優先
- コミュニティの意見も参考にする

### 3. セキュリティ
- 機密情報を含むクエリは避ける
- 個人情報は含めない
- 適切な権限で実行

---

## トラブルシューティング

### よくある問題

#### 1. APIキーエラー
```bash
# 解決方法
export GEMINI_API_KEY="your-api-key-here"
echo $GEMINI_API_KEY  # 確認
```

#### 2. ネットワークエラー
- インターネット接続を確認
- プロキシ設定を確認
- ファイアウォール設定を確認

#### 3. 検索結果が不適切
- キーワードを変更
- より具体的な検索語を使用
- 年号やバージョンを指定

---

## セキュリティとプライバシー

### 注意事項
- 機密情報を含む検索は避ける
- 個人情報は含めない
- 適切な権限で実行

### ベストプラクティス
- 検索履歴を定期的にクリア
- 機密プロジェクトでは使用を制限
- チーム内でガイドラインを共有

---

## 今後の拡張予定

### 計画中の機能
- 検索履歴の保存
- お気に入り検索の管理
- 自動化スクリプトの統合

### 改善点
- 検索精度の向上
- 多言語対応の強化
- 統合開発環境との連携

---

## まとめ

Gemini CLI ツールは、開発効率を大幅に向上させる強力なツールです。
適切な使用方法とベストプラクティスを守ることで、安全で効率的な開発が可能になります。

### 重要なポイント
1. **環境チェック**: 使用前に必ず環境チェックを実行
2. **適切なクエリ**: 具体的で明確な検索クエリを使用
3. **セキュリティ**: 機密情報を含む検索は避ける
4. **継続的学習**: 新しい機能やベストプラクティスを学ぶ 
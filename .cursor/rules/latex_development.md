# LaTeX Development Rules with AI-Driven Coding Support

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
conda activate py-review  # または適切な環境名

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
# シェルスクリプト版
./utility/start.sh

# Pythonスクリプト版
python utility/start.py
```

#### 方法2: 直接実行
```bash
# プロジェクトルートで実行
echo "スタート" | python -c "
import sys
sys.path.append('utility')
from check_env import main
main()
"
```

#### 方法3: ワンライナー
```bash
# スタートコマンドの実行
python -c "import sys; sys.path.append('utility'); from check_env import main; main()"
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

## Environment Setup

### LaTeX Environment
- LaTeX ドキュメントをビルドする前に、必要な LaTeX パッケージがインストールされていることを確認すること
- Ensure all necessary LaTeX packages are installed before building documents:
  ```bash
  # Ubuntu/Debian
  sudo apt install texlive-full
  
  # macOS (with Homebrew)
  brew install --cask mactex
  ```

## File Creation and Output Rules

### Default Working Directory
- 特別な指示がない限り、LaTeX ソースファイルの作成は `tex` フォルダ内で行う
- Unless specifically instructed otherwise, create LaTeX source files within the `tex` folder

### File Organization
- メインファイル: `tex/main.tex`
- プリアンブル（パッケージ定義）: `tex/preamble.tex`
- セクション・章: `tex/sections/` ディレクトリ
- 参考文献: `tex/bib/` ディレクトリ
- 画像・図表: `figures/` ディレクトリ

### Path References
- LaTeX ファイル内での相対パス参照は `tex/` ディレクトリからの相対パスを使用
- 図表の参照は `\graphicspath{{../figures/}}` で設定済み

### Build Process
- ビルドには `latexmk` を使用:
  ```bash
  cd tex && latexmk -pdf main.tex
  ```
- クリーンアップ:
  ```bash
  cd tex && latexmk -C
  ```

### Examples
- ✅ 新しいセクションの作成: `tex/sections/new_section.tex`
- ✅ 図表の配置: `figures/graph.png`
- ✅ 参考文献の追加: `tex/bib/refs.bib`
- ❌ ソースファイルをルートディレクトリに配置しない
- ❌ 画像ファイルを `tex/` ディレクトリ内に配置しない 
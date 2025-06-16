# LaTeX Development Rules

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
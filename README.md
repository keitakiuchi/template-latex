# LaTeX Template

日本語論文・レポート作成のための LaTeX テンプレート

## 特徴

- 日本語と英語の両方に対応
- VS Code / Cursor での編集に最適化
- GitHub Actions による自動ビルド
- クリーンで整理された構造
- 自動クリーンアップ機能付き

## ディレクトリ構造

```
template-latex/
├─ .vscode/              ← VS Code／Cursor 専用設定
│   ├─ settings.json
│   └─ tasks.json
├─ .github/
│   └─ workflows/        ← CI 用 GitHub Actions
│       └─ latex.yml
├─ tex/                  ← LaTeX ソース一式
│   ├─ main.tex          ← メインファイル（\input で各章を読み込む）
│   ├─ preamble.tex      ← パッケージ類を集約
│   ├─ title.tex         ← タイトルページ設定
│   ├─ sections/
│   │   ├─ intro.tex
│   │   └─ conclusion.tex
│   └─ bib/              ← 参考文献
│       ├─ refs.bib
│       └─ sample.bib
├─ build/                ← 生成ファイル（自動生成）
│   └─ pdf/              ← PDF出力
├─ scripts/              ← スクリプト類
│   ├─ compile.sh        ← コンパイルスクリプト
│   └─ tex2docx.sh       ← TeX→Word変換スクリプト
├─ figures/              ← 画像・図表
├─ latexmkrc             ← latexmk のカスタム設定
├─ .gitignore
├─ README.md
└─ LICENSE               ← GPL v3
```

## 使い方

### 前提条件

- TeX Live または MacTeX のインストール
- pandoc（TeX→Word変換用、オプション）
- VS Code + LaTeX Workshop 拡張機能（推奨）

### コンパイル方法

#### VS Code / Cursor を使用する場合

1. このリポジトリをクローンまたはダウンロード
2. VS Code / Cursor でフォルダを開く
3. `tex/main.tex` を開く
4. LaTeX Workshop 拡張機能のビルドボタンをクリック、または `Ctrl+Alt+B` (`Cmd+Alt+B` on Mac) でビルド

#### コマンドラインを使用する場合

```bash
# リポジトリのルートディレクトリで（推奨）
./scripts/compile.sh
```

または手動で：

```bash
# プロジェクトルートから実行する場合
cd tex
latexmk -r ../latexmkrc main.tex
```

> **注意**: 
> - 生成されたPDFは `build/pdf/` に出力されます。
> - `tex` ディレクトリ内で `-r ../latexmkrc` を指定せずに実行すると、デフォルトのコンパイラ（pdfTeX）が使用され、日本語処理でエラーが発生します。
> - `latexmkrc` ファイルには LuaLaTeX の設定や出力先ディレクトリの指定が含まれています。
> - コンパイル後は自動的に一時ファイルがクリーンアップされます。

#### TeX→Word変換（オプション）

```bash
# TeXファイルをWordに変換
./scripts/tex2docx.sh tex/main.tex
```

> **注意**: 
> - 生成されたWordファイルは `build/docx/` に出力されます。
> - 変換には `pandoc` を使用しています。インストールされていない場合は `sudo apt install pandoc` でインストールしてください。
> - 一部のLaTeXパッケージやコマンドは変換時に警告が出る場合がありますが、基本的なテキスト内容と構造は保持されます。

### カスタマイズ

- `tex/preamble.tex`: パッケージや設定を追加・変更
- `tex/main.tex`: 文書のタイトル、著者名などを変更
- `tex/title.tex`: タイトルページのレイアウトを変更
- `latexmkrc`: コンパイル設定を変更

## 新規セクションの追加

1. `tex/sections/` に新しい `.tex` ファイルを作成
2. `tex/main.tex` に `\input{sections/新ファイル名}` を追加

## 参考文献の追加

1. `tex/bib/refs.bib` に BibTeX 形式で追加
2. 本文中で `\cite{引用キー}` で引用

## ライセンス

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)

本ソフトウェアは **GNU General Public License v3.0 以降（GPL-3.0-or-later）** の下で配布されています。  
詳細はリポジトリ同梱の [LICENSE](LICENSE) ファイルをご覧ください。

## TeX Live のインストール

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install texlive-full texlive-lang-japanese
```

### macOS

```bash
# Homebrew を使用
brew install --cask mactex

# または BasicTeX（軽量版）
brew install --cask basictex
```

### Windows

1. [TeX Live](https://www.tug.org/texlive/) からインストーラーをダウンロード
2. インストーラーを実行し、scheme-full を選択

## トラブルシューティング

| 症状                             | 解決策                                                         |
| ------------------------------ | ----------------------------------------------------------- |
| `Please (re)run Biber...`      | `biber main` → `latexmk -lualatex main.tex` |
| `Missing character (nullfont)` | 通常は無視可。PDF 内に "?" が残るならフォント設定を確認                            |
| 日本語が表示されない                    | LuaLaTeX を使用していることを確認（`latexmkrc` の設定を確認） |

## 貢献

プルリクエストやイシューの報告を歓迎します。大きな変更を行う場合は、まずイシューで議論してください。
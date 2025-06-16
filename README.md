# LaTeX Template

日本語論文・レポート作成のための LaTeX テンプレート

## 特徴

- 日本語と英語の両方に対応
- VS Code / Cursor での編集に最適化
- GitHub Actions による自動ビルド
- クリーンで整理された構造

## ディレクトリ構造

```
latex-template/
├─ .vscode/              ← VS Code／Cursor 専用設定
│   ├─ settings.json
│   └─ tasks.json
├─ .github/
│   └─ workflows/        ← CI 用 GitHub Actions
│       └─ latex.yml
├─ tex/                  ← LaTeX ソース一式
│   ├─ main.tex          ← エントリポイント（\input で各章を読み込む）
│   ├─ preamble.tex      ← パッケージ類を集約
│   ├─ sections/
│   │   ├─ intro.tex
│   │   └─ conclusion.tex
│   └─ bib/              ← 参考文献
│       └─ refs.bib
├─ figures/              ← 画像・図表
├─ latexmkrc             ← latexmk のカスタム設定
├─ .gitignore
├─ README.md
└─ LICENSE               ← MIT など
```

## 使い方

### 前提条件

- TeX Live または MacTeX のインストール
- VS Code + LaTeX Workshop 拡張機能（推奨）

### コンパイル方法

#### VS Code / Cursor を使用する場合

1. このリポジトリをクローンまたはダウンロード
2. VS Code / Cursor でフォルダを開く
3. `tex/main.tex` を開く
4. LaTeX Workshop 拡張機能のビルドボタンをクリック、または `Ctrl+Alt+B` (`Cmd+Alt+B` on Mac) でビルド

#### コマンドラインを使用する場合

```bash
# リポジトリのルートディレクトリで
cd tex
latexmk -pdf main.tex
```

### カスタマイズ

- `tex/preamble.tex`: パッケージや設定を追加・変更
- `tex/main.tex`: 文書のタイトル、著者名などを変更
- `latexmkrc`: コンパイル設定を変更

## ライセンス

MIT License

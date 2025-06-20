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
├─ build/                ← 生成ファイル（自動生成）
│   ├─ pdf/              ← PDF出力
│   ├─ docx/             ← Word出力（予定）
│   └─ aux/              ← 中間ファイル
├─ scripts/              ← スクリプト類
│   ├─ compile.sh        ← コンパイルスクリプト
│   └─ tex2docx.sh       ← TeX→Word変換スクリプト
├─ figures/              ← 画像・図表
├─ latexmkrc             ← latexmk のカスタム設定
├─ .gitignore
├─ README.md
└─ LICENSE               ← MIT など
```

## 使い方

### 前提条件

- TeX Live または MacTeX のインストール（詳細は後述）
- pandoc（TeX→Word変換用、詳細は後述）
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
./scripts/compile.sh
```

または手動で：

```bash
cd tex
latexmk -r ../latexmkrc main.tex
```

> **注意**: 生成されたPDFは `build/pdf/` に出力されます。

#### TeX→Word変換

```bash
# TeXファイルをWordに変換
./scripts/tex2docx.sh tex/main.tex
```

> **注意**: 生成されたWordファイルは `build/docx/` に出力されます。
> 一部のLaTeXパッケージは変換時に警告が出る場合がありますが、基本的なテキスト変換は正常に動作します。

### カスタマイズ

- `tex/preamble.tex`: パッケージや設定を追加・変更
- `tex/main.tex`: 文書のタイトル、著者名などを変更
- `latexmkrc`: コンパイル設定を変更

## ライセンス

MIT License

## TeX Live 2025 最新版のインストール手順（WSL Ubuntu）

> **対象**: Windows + WSL2 環境で本リポジトリを使う人  
> **所要時間**: フルインストールで 30 〜 60 分（ダウンロード速度次第）
（重い部分を外付けSSDに入れる方法は後述）

### 1 古い apt 版 TeX Live の削除（任意）

```bash
# 確認だけしたい場合は -s を付ける
# sudo apt-get -s remove --purge 'texlive*' 'context*' 'biber'

sudo apt remove --purge 'texlive*' 'context*' 'biber'
sudo apt autoremove --purge
```

> この時点で `texinfo`, `texinfo-lib`, `tex-common` だけ残る場合があります。
> それらも不要なら
> `sudo apt remove --purge texinfo tex-common && sudo apt autoremove --purge`
> で完全に消せます。

### 2 公式インストーラの取得と実行

```bash
# 依存パッケージ
sudo apt update
sudo apt install -y perl wget xz-utils fontconfig pandoc

# ネットインストーラを入手
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzf install-tl-unx.tar.gz
cd install-tl-*/

# 対話インストーラを起動（推奨: scheme-full）
sudo perl install-tl
```

1. 画面で `scheme-full` を選択 → `I` で開始
2. ※容量を抑えたい場合は `scheme-small` でも OK（後から個別追加可）

### 3 PATH を通す（恒久設定）

```bash
echo 'export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH' >> ~/.profile
source ~/.profile
```

### 4 動作確認

```bash
which latexmk    # /usr/local/texlive/2025/bin/latexmk
latexmk -v       # Version 4.86a 以上
biber --version  # 2.25 以上

# 最小テスト
echo '\documentclass{article}\begin{document}Hello\end{document}' > test.tex
latexmk -lualatex test.tex
# test.pdf が出来れば成功
```

### 5 ビルドエラー時のチェックポイント

| 症状                             | 解決策                                                         |
| ------------------------------ | ----------------------------------------------------------- |
| `Please (re)run Biber...`      | `biber main` → `latexmk -lualatex main.tex`                 |
| `Missing character (nullfont)` | 通常は無視可。PDF 内に "?" が残るならフォント設定を確認                            |
| apt 版が復活する                     | `apt-mark hold texlive-base texlive-binaries` で再インストールをブロック |

---

> **ヒント**: プロジェクト直下に `latexmkrc` を置き、
>
> ```perl
> $bibtex_use = 2;   # biber を優先
> ```
>
> と書いておくと、`latexmk -lualatex` だけで BibLaTeX + biber が確実に走ります。




## TeX Live を外付けSSDで運用する（方式 B: tiny + full）

> - **目的**:  
>   - 内蔵ストレージをほぼ消費せずにフル機能の TeX Live 2025 を使う  
>   - 外付けSSDが無い状況でも「欧文だけならコンパイル可」にしておく  
> - **前提**:  
>   - 外付けSSD が Windows で `E:` → WSL 上は `/mnt/e` にマウントされる  
>   - WSL ディストリ: Ubuntu 20.04 以降

### 1. 内蔵SSDへ *scheme-tiny* を導入（約 100 MB）

```bash
sudo perl install-tl -profile - <<'EOF'
selected_scheme scheme-tiny
TEXDIR /usr/local/texlive/tiny
TEXMFCONFIG ~/.texlive2025
TEXMFVAR   ~/.texlive2025
TEXMFHOME  ~/texmf
collection-langjapanese 0   # tiny には日本語フォントが含まれない
option_doc 0
option_src 0
EOF
```

### 2. 外付けSSDへ *scheme-full* の TeX Live 2025 をインストール

```bash
# SSD 側に専用ディレクトリを作成
sudo mkdir -p /mnt/e/texlive

# ネットインストーラを同様に実行
cd install-tl-*/
sudo perl install-tl
# インストーラ画面で
#   T (installation directory) → /mnt/e/texlive/2025
#   scheme-full を選択 → I で開始
```

所要ディスク: 約 6 GB（SSD に配置）

### 3. PATH を「外付け優先 → 内蔵 tiny」を自動切替に設定

`~/.bashrc` 末尾に追記:

```bash
# ----- TeX Live dynamic PATH -----
TL_FULL="/mnt/e/texlive/2025/bin/x86_64-linux"
TL_TINY="/usr/local/texlive/tiny/bin/x86_64-linux"

if [ -d "$TL_FULL" ]; then
    export PATH="$TL_FULL:$TL_TINY:$PATH"
    echo "[TeX] Using FULL TeX Live at $TL_FULL"
else
    export PATH="$TL_TINY:$PATH"
    echo "[TeX] Using tiny TeX Live (no Japanese) — connect SSD for full features"
fi
# ---------------------------------
```

* 挿したまま起動 → **FULL** が優先
* 抜いた状態で起動 → **tiny** に自動フォールバック
  （日本語文書をコンパイルするとエラーになりますが、欧文の簡易テストには十分）

### 4. 動作確認

1. **SSD 挿入時**

   ```bash
   source ~/.bashrc
   which latexmk        # /mnt/e/texlive/2025/bin/latexmk
   latexmk -lualatex main.tex   # 日本語＋BibLaTeX まで通る
   ```

2. **SSD 取り外し時**

   ```bash
   source ~/.bashrc
   which latexmk        # /usr/local/texlive/tiny/bin/latexmk
   latexmk test.tex     # 欧文のみ OK、日本語はフォントエラー
   ```

### 5. よくある質問

| Q                              | A                                                                               |
| ------------------------------ | ------------------------------------------------------------------------------- |
| **SSD を抜いたまま誤って日本語ビルドすると？**    | `\CJK@char` などのエラーで停止します。SSD を挿し直して再実行してください。                                   |
| **tiny 版に不足パッケージを手動追加しても大丈夫？** | 可能ですが、容量が増えるほど *tiny* の意義が薄れます。Full 版がある前提なら追加不要です。                             |
| **SSD のドライブレターが変わる場合**         | Windows の「ディスクの管理」で固定ドライブレターを設定するか、`/etc/wsl.conf` + `fstab` で UUID マウントを推奨します。 |

---

これで **外付け有無に応じた自動切り替え** が実現できます。







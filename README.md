# LaTeX Template with AI-Driven Coding Support

日本語論文・レポート作成のための LaTeX テンプレート（AI駆動コーディング対応版）

## 特徴

- 日本語と英語の両方に対応
- VS Code / Cursor での編集に最適化
- GitHub Actions による自動ビルド
- クリーンで整理された構造
- **AI駆動コーディングのサポート**
  - Claude AI アシスタント統合
  - Gemini CLI 検索機能
  - Cursor IDE 最適化
  - 自動化された開発ワークフロー
- **🚀 自動スタート機能**
  - 「スタート」と入力するだけで環境チェックを自動実行
  - 開発環境の自動セットアップ

## AI駆動コーディング機能

### 対応AIツール
- **Claude Code CLI**: コード生成・改善・レビュー
- **Claude Code GitHub Actions**: CI/CD統合
- **OpenAI Codex**: コード補完・生成
- **Gemini CLI**: ウェブ検索・技術情報取得
- **Cursor**: AI統合開発環境

### ルールファイルの概念
このプロジェクトでは、各AIツール向けに専用のルールファイルを提供しています：

#### ルールファイルの役割
- **開発ガイドライン**: プロジェクト固有の開発ルールとベストプラクティス
- **環境設定**: 適切な開発環境の構築と確認方法
- **ツール統合**: 各AIツールの効果的な使用方法
- **品質保証**: コード品質とセキュリティの基準
- **AIエージェント設定**: 各AIツールの設定と活用方法
- **ワークフロー統合**: CI/CDとAIツールの連携方法

#### ルールファイルの構成
```
.cursor/rules/           # Cursor IDE用ルール
├─ ai_driven_coding.md   # AI駆動コーディングの総合ガイド
└─ latex_development.md  # LaTeX開発専用ルール

.claude/commands/        # Claude AI用コマンド
└─ gemini-search.md      # Gemini検索機能の使用方法

ルートディレクトリのルールファイル
├─ AGENTS.md             # AIエージェント統合ガイド
├─ CLAUDE.md             # Claude AI設定・活用ガイド
└─ ai-driven-coding.md   # AI駆動コーディング総合テンプレート
```

#### ルールファイルの特徴
- **プロジェクト特化**: このプロジェクトに最適化
- **環境チェック統合**: 開発開始前の環境確認を自動化
- **継続的更新**: プロジェクトの進化に合わせて更新
- **多ツール対応**: 様々なAIツールとの連携をサポート
- **階層化構造**: 用途別に整理されたルールファイル群
- **統一された環境設定**: すべてのルールファイルで一貫した環境設定

### 環境チェック（重要）
コードを実行する前に、必ず環境チェックを実行してください：

```bash
# 仮想環境のアクティベート
conda activate latex-template  # または適切な環境名

# 環境チェックスクリプトの実行
python utility/check_env.py
```

### クイックスタート
**🚀 自動スタート機能**: 「スタート」と入力すると、AIアシスタントが自動的に`python utility/start.py`を実行し
、仮想環境の自動アクティベートと環境チェックを実行して処理環境を整えます：

#### 最も簡単な方法
```bash
# AIアシスタントに「スタート」と入力するだけ
# 自動的に以下が実行されます：
# 1. latex-template 環境の自動アクティベート
# 2. 環境チェックの実行
python utility/start.py
```

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

### AIツールの使用方法

#### Claude AI アシスタント
```bash
# GitHub Issuesで@claudeをメンション
# プルリクエストレビューで@claudeをメンション
```

#### Gemini CLI 検索
```bash
# 技術情報の検索
gemini --prompt "WebSearch: Python async programming best practices 2024"

# APIドキュメントの検索
gemini --prompt "WebSearch: OpenAI API documentation"
```

#### Cursor IDE
- `.cursor/rules/` ディレクトリのルールファイルを参照
  - `ai_driven_coding.md` - AI駆動コーディングのルールとベストプラクティス
  - `latex_development.md` - LaTeX開発のルールとファイル構成
- AI駆動開発のベストプラクティスに従った開発

#### Claude AI アシスタント
- `.claude/commands/` ディレクトリのコマンドファイルを参照
  - `gemini-search.md` - Gemini CLI検索機能の使用方法
- GitHub Issuesやプルリクエストで@claudeをメンション

## ディレクトリ構造

```
template-latex/
├─ .claude/               ← Claude 設定
│   ├─ claude.yml
│   └─ commands/
│       └─ gemini-search.md
├─ .codex/                ← Codex CLI/IDE 設定
│   └─ config.toml
├─ .cursor/               ← Cursor ルール
│   └─ rules/
│       ├─ latex_development.md
│       └─ cursorrules.md
├─ .github/
│   └─ workflows/        ← CI / AI ワークフロー
│       ├─ claude.yml
│       ├─ codex-tdd.yml
│       └─ latex.yml
├─ .vscode/              ← VS Code／Cursor 設定
│   ├─ settings.json
│   └─ tasks.json
├─ build/                ← 生成ファイル（自動生成）
│   └─ pdf/              ← PDF 出力
├─ figures/              ← 図表（TeX からは ../figures/ を参照）
│   └─ .gitkeep
├─ plan/                 ← タスク計画メモ
│   └─ .gitkeep
├─ results/              ← 実行結果・ログ
│   └─ .gitkeep
├─ sharing/              ← 共有ユーティリティ
│   ├─ ai-driven-coding.py
│   └─ ai-driven-coding.md
├─ scripts/              ← ビルド / 変換スクリプト
│   ├─ compile.sh
│   └─ tex2docx.sh
├─ tex/                  ← LaTeX ソース一式
│   ├─ example.tex       ← メインファイル例（\input で各章を読み込む）
│   ├─ title.tex         ← タイトルページ設定
│   ├─ sections/
│   │   ├─ intro.tex
│   │   └─ conclusion.tex
│   └─ bib/              ← 参考文献
│       ├─ refs.bib
│       └─ sample.bib
├─ utility/              ← 環境チェック / セットアップ
│   ├─ check_env.py
│   ├─ start.py
│   └─ start.sh
├─ workbench/            ← 実験スペース
│   └─ .gitkeep
├─ ai-driven-coding.md   ← AI プレイブック
├─ environment.yml       ← conda 補助環境定義 (latex-template)
├─ latexmkrc             ← latexmk のカスタム設定
├─ requirements.txt      ← Python依存関係
├─ texlive-tiny.profile  ← TeX Live設定プロファイル
├─ env.example           ← 環境変数設定例
├─ .gitignore
├─ README.md
├─ AGENTS.md             ← AIエージェント統合ガイド
├─ CLAUDE.md             ← Claude AI設定・活用ガイド
├─ ai-driven-coding.md   ← AI駆動コーディング総合テンプレート
└─ LICENSE               ← GNU GPL v3
```

## 使い方

### 前提条件

- TeX Live 2025（scheme-medium以上）のインストール済み
- pandoc（TeX→Word変換用）
- VS Code + LaTeX Workshop 拡張機能（推奨）

### 初期セットアップ

```bash
python utility/start.py --install
# もしくは
INSTALL_DEPS=true ./utility/start.sh
```

- `utility/check_env.py` がすべて `[OK]` を返すことを確認します。
- 失敗した場合はログを `results/` に保存し、Issue で共有してください。

### コンパイル方法

#### VS Code / Cursor を使用する場合

1. このリポジトリをクローンまたはダウンロード
2. VS Code / Cursor でフォルダを開く
3. `tex/example.tex` を開く（推奨）
4. LaTeX Workshop 拡張機能のビルドボタンをクリック、または `Ctrl+Alt+B` (`Cmd+Alt+B` on Mac) でビルド

#### コマンドラインを使用する場合

```bash
# リポジトリのルートディレクトリで（推奨）
./scripts/02_compile.sh
```

または手動で：

```bash
# プロジェクトルートから実行する場合
cd tex
latexmk -r ../latexmkrc example.tex
```

#### 不足パッケージの自動インストール

LaTeXコンパイル時に「パッケージが見つからない」エラーが発生した場合、以下のスクリプトで不足しているパッケージを自動でインストールできます：

```bash
# 不足しているLaTeXパッケージを自動検出・インストール
./scripts/01_install_missing_packages.sh
```

**使用方法：**
1. プロジェクトルートディレクトリで実行
2. スクリプトが自動的に`tex/example.tex`をコンパイルしてエラーを検出
3. 不足しているパッケージを自動でインストール
4. インストール完了後、再度コンパイルを試行

**注意事項：**
- 管理者権限（sudo）が必要です
- TeX Live 2025がインストールされている必要があります
- フォント関連のエラーは手動で対応が必要な場合があります
- スクリプト内の`TARGET_TEX_FILE`変数で対象ファイルを変更可能です

> **注意**: 
> - 生成されたPDFは `build/pdf/` に出力されます。
> - コンパイル済みの参考文献（.bblファイル）は `tex/bib/` に出力されます。
> - 中間ファイル（.aux、.log、.bblなど）は `tex/temp/` に保持されます。
> - `tex` ディレクトリ内で `-r ../latexmkrc` を指定せずに実行すると、デフォルトのコンパイラ（pdfTeX）が使用
され、日本語処理でエラーが発生します。
> - `latexmkrc` ファイルには LuaLaTeX の設定や出力先ディレクトリの指定が含まれています。

#### コンパイル後の成果物

`./scripts/02_compile.sh` を実行すると、以下の成果物が生成されます：

**最終成果物（配布・共有用）:**
- `build/pdf/example.pdf` - 完成したPDFファイル
- `tex/bib/example.bbl` - コンパイル済み参考文献（引用が解決済み）

**中間ファイル（デバッグ・再コンパイル用）:**
- `tex/temp/example.aux` - 引用情報
- `tex/temp/example.log` - コンパイルログ
- `tex/temp/example.bbl` - 一時的な参考文献ファイル

#### クリーンアップオプション:**
```bash
# 中間ファイルをクリーンアップしてからコンパイル
./scripts/02_compile.sh example --clean

# コンパイル後に一時ファイルのみクリーンアップ
./scripts/02_compile.sh example --clean-temp

# 完全クリーンアップ（両方のオプション）
./scripts/02_compile.sh example --clean --clean-temp
```

#### クリーンアップスクリプト

ビルドファイルや一時ファイルを整理するための専用スクリプトも用意しています：

```bash
# すべてのビルドファイルをクリーンアップ
./scripts/05_cleanup.sh --all

# 一時ファイルのみクリーンアップ
./scripts/05_cleanup.sh --temp

# ビルド出力のみクリーンアップ
./scripts/05_cleanup.sh --build

# ヘルプ表示
./scripts/05_cleanup.sh --help
```

**クリーンアップスクリプトの機能：**
- `--all`: 一時ファイルとビルド出力の両方を削除
- `--temp`: `tex/temp/`ディレクトリ内の一時ファイルのみ削除
- `--build`: `build/`ディレクトリ内のビルド出力のみ削除
- 安全な削除処理（重要なファイルは保持）

#### TeX→Word変換

```bash
# TeXファイルをWordに変換
./scripts/03_tex2docx.sh tex/example.tex
```

> **注意**: 
> - 生成されたWordファイルは `build/docx/` に出力されます。
> - 変換には `pandoc` を使用しています。インストールされていない場合は `sudo apt install pandoc` でインスト
ールしてください。
> - 一部のLaTeXパッケージやコマンド（特に数式や特殊な書式）は変換時に警告が出る場合がありますが、基本的なテ
キスト内容と構造は保持されます。
> - 変換中に表示される多数の警告メッセージは無視して問題ありません。
> - 日本語を含む文書も変換可能ですが、フォントや一部の書式が完全に再現されない場合があります。
> - 変換後のWordファイルは必要に応じて手動で調整することをお勧めします。

#### テーブルデータの抽出

```bash
# LaTeXファイルからテーブルをCSV形式で抽出
./scripts/04_extract_tables.sh tex/example.tex
```

> **機能**: 
> - LaTeXファイル内の`\begin{table}`環境からテーブルを自動検出・抽出
> - 複数のテーブル環境（`tabular`、`longtable`、`tabularx`）に対応
> - インライン数式（`$...$`、`\(...\)`、`\[...\]`）を文字列として保持
> - `\multicolumn`コマンドや`booktabs`コマンドを適切に処理
> - 抽出されたテーブルは`build/csv/`ディレクトリにCSV形式で保存
> - 各テーブルは`ファイル名_table_01.csv`、`ファイル名_table_02.csv`の形式で保存
> - 日本語テキストや数式記号（`±`、`≤`、`≥`、`≠`など）を適切に処理

### カスタマイズ

- `tex/sections/preamble.tex`: パッケージや設定を追加・変更
- `tex/example.tex`: 文書のタイトル、著者名などを変更
- `tex/title.tex`: タイトルページの設定を変更
- `latexmkrc`: コンパイル設定を変更

## トラブルシューティング

### よくある問題と解決方法

#### 1. TeX Liveのパスが見つからない

```bash
# エラー: TeX Liveのパスが自動検出できませんでした
# 解決方法: 環境変数を設定
export TEXLIVE_PATH="/usr/local/texlive/2025/bin/x86_64-linux"
# または
export TEXLIVE_PATH="/mnt/d/texlive/2025/bin/x86_64-linux"
```

#### 2. SSD上のTeX Liveにアクセスできない

```bash
# エラー: 日本語フォントが見つからない、コンパイルエラー
# 原因: SSDがマウントされていない、またはPATHが正しく設定されていない

# 解決方法1: SSDのマウント確認
ls /mnt/e/texlive/2025/bin/  # Eドライブの場合
ls /mnt/d/texlive/2025/bin/  # Dドライブの場合

# 解決方法2: 環境変数の設定
export TEXLIVE_PATH="/mnt/e/texlive/2025/bin/x86_64-linux"  # Eドライブ
export TEXLIVE_PATH="/mnt/d/texlive/2025/bin/x86_64-linux"  # Dドライブ

# 解決方法3: 恒久設定
echo 'export TEXLIVE_PATH="/mnt/e/texlive/2025/bin/x86_64-linux"' >> ~/.bashrc
source ~/.bashrc
```

#### 3. 日本語フォントエラー

```bash
# エラー: Missing character (nullfont)
# 解決方法: 日本語フォントパッケージをインストール
sudo apt install fonts-ipafont fonts-ipafont-gothic fonts-ipafont-mincho
```

#### 4. ビルドディレクトリの権限エラー

```bash
# エラー: Permission denied
# 解決方法: ディレクトリの権限を確認
ls -la build/
chmod 755 build/
```

#### 5. 依存パッケージの不足

```bash
# エラー: Package not found
# 解決方法: 不足パッケージを自動インストール
./scripts/01_install_missing_packages.sh
```

### ログファイルの確認

コンパイルエラーが発生した場合は、以下のログファイルを確認してください：

- `tex/temp/example.log` - 詳細なコンパイルログ
- `tex/temp/example.aux` - 引用情報
- `tex/temp/example.blg` - BibTeXログ

## ライセンス

GNU General Public License v3.0

このプロジェクトはGNU GPL v3ライセンスの下で公開されています。詳細は[LICENSE](LICENSE)ファイルを参照してください。

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




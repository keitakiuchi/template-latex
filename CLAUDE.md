CLAUDE.md

概要

本ドキュメントは、Claude Code Action における設定ファイルの構成・運用ルール・ファイル保存ポリシーを整理したものです。
GitHub Actions 側の .github/workflows/claude.yml と、Claude セッション側の .claude/claude.yml の二層構成で管理します。


---

設定ファイルの役割と責務

.github/workflows/claude.yml：Claude Code Action の「外側」設定

目的

Claude Code をいつ・どのイベントで実行するかを定義

実行環境の構成（OS、Python バージョン、Secrets）

依存ライブラリのインストール、CI レベルの前処理・後処理


変更が必要となるタイミング

Action バージョンの更新（例：@v1 → @v2）

新しいパッケージや環境設定の追加

実行トリガーやタイムアウトの条件変更




---

.claude/claude.yml：Claude セッションの「内側」設定

目的

Claude セッション中に適用されるルールの定義（system_prompt）

使用可能なコマンド（allowed_tools）の制限

timeout_minutes や並列実行数など Claude の内部動作を制御


変更が必要となるタイミング

保存先ディレクトリルールなど社内規約の追加・更新

使用ツールや応答テンプレートの更新

Claude の動作チューニング




---

出力・保存ポリシー

解析結果ファイル

すべて results/ ディレクトリに保存すること
指示がない限り、コードで生成された成果物は results/ に保存し PR に含めること
ファイル名が既存と衝突する場合は `_1`, `_2` など連番を付ける

setup.sh により results/ は必ず作成される


データセット

data/ ディレクトリに保存

setup.sh により data/ は必ず作成される


上書きとコミットのルール

data/ 内のファイルを更新した場合は、同一ブランチでステージ＆コミット

results/ または data/ に出力された成果物が PR に含まれていない場合、不完全なタスクと見なす

ログファイルのみの提出は不可



---

実行ルール

1. 解析はすべて Python スクリプト（*.py）から実行


2. R を使用する場合は、Python 経由で以下のいずれかにより実行すること：

subprocess による Rscript 呼び出し

rpy2 によるインライン実行



3. .R ファイルを直接実行するワークフローは禁止



コード記述規約

コメント以外のコードに全角文字を使用しない

UI文字列などで日本語が必要な場合は、定数に切り出し # noqa: UTF-8 を付与



---

検証と自己チェック

解析後、results/ 内に期待される成果物が存在するかを確認する

テスト時はファイル数・ファイル名をチェックして合否判定を行う



---

エラー処理と診断

エラー発生時には以下の手順に従う：

1. 詳細の記録

results/error_<timestamp>.log に stdout / stderr を保存

exit code、失敗コマンドやトレースバックも含める



2. 原因の特定

ログを解析して原因分類（例：依存不足、パス不備、Rスクリプトのクラッシュ）



3. 修正案の提示

results/fix_<timestamp>.txt に以下を30行以内で記載

何が失敗したか

なぜ失敗したか（根拠や仮説）

どう修正すべきか（コードまたは手順）




4. 報告

Ask モードではチャット出力にエラー要約を含める

Code モードでは PR の ### Failure Analysis セクションに記載



5. 再実行ポリシー

修正適用後は1回だけ再実行し、再失敗時はログを上書きせず別ファイルで保存



6. 依存モジュール不足時

requirements.txt に追記後、テストを再実行すること





---

ノートブック生成ルール

make notebook により、analysis_steps/*.py を順に Notebook 化

出力先：notebooks_build/execution_log.ipynb（※Git 管理対象外）

各セル構成：

1. Markdown 見出し（例：「001 – Summarize Dataset」）


2. スクリプト本文を含むコードセル



ログや標準出力は Notebook に含めない



---

スクリプト配置・命名ルール

1. すべての解析スクリプトは analysis_steps/ に配置


2. ファイル名は NNN_<slug>.py とし、NNN は 001 から連番で管理


3. 途中番号を飛ばさず、最大番号+1を採番


4. <slug> は処理内容を表す英小文字＋アンダースコア（20文字以内）


5. 実行は以下のように行う：

python analysis_steps/NNN_<slug>.py




---

Claude Code 管理ベストプラクティス

allowed_tools は .claude/claude.yml にのみ記述

ブランチ名は ASCII のみ使用（例：fix-r-output）

Claude Action 呼び出しは config_file: .claude/claude.yml を指定

バージョンは必ず固定タグ（例：@v1）を使用



---

運用変更の例（推奨フロー）

1. .claude/claude.yml に allowed_tools: ["Bash(*)", "Edit"] を追加


2. .github/workflows/claude.yml で Run Claude Code ステップの @v1 を明示


3. CI が成功することを確認して fix/claude-config ブランチで PR 作成


4. レビュー後 main にマージ

---

許可される上書きポリシー

allow_overwrite:
  - path: data/**/*.csv
    max_size_mb: 20

# CLAUDE.md

このファイルは Claude Code 用のプロジェクト共有メモです。
共通ルールは簡潔に保ち、詳細は `.claude/rules/` に分割します。

## 基本方針

- ユーザー向けの回答、進捗報告、要約は常に日本語で行う。
- このリポジトリはテンプレート本体なので、`src/` や `tests/` が未作成でも不整合ではない。新規コードを追加するときだけ規約どおりに作る。
- プロジェクトコードを実行する前に `python utility/check_env.py` を実行する。
- ローカル開発の依存関係の正本は `environment.yml`。`requirements.txt` は主に GitHub Actions / 互換用途として扱う。
- Claude Code の公式な共有設定は `CLAUDE.md` と `.claude/settings.json`。`.claude/claude.yml` は既存互換ファイルとして扱う。
- 既存の skill や command で片付く作業は、長いアドホック指示よりも `.claude/skills/` と `.claude/commands/` を優先する。

## モジュール化された補助ルール

@.claude/rules/claude-code-mapping.md
@.claude/rules/project-structure.md
@.claude/rules/development-workflow.md
@.claude/rules/security.md

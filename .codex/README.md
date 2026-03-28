# `.codex` 運用メモ

このディレクトリは、Codex CLI/IDE のプロジェクト単位設定を置く場所です。

## 現在の方針

- 既定値は `approval_policy = "on-request"` と `sandbox_mode = "workspace-write"`
- Web 検索は `web_search = "live"` で有効
- シェルの外向きネットワークは既定で無効
- 言語・コーディング規約・運用ルールはリポジトリ直下の `AGENTS.md` で管理

## 使い分け

通常作業:

```bash
codex
```

シェルでネットワークが必要な作業:

```bash
codex --profile networked
```

## 確認

```bash
python utility/check_env.py
```

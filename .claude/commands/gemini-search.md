# Gemini Search Command

Claude Code から Web 検索が必要なときは、原則として Gemini CLI を次の形式で使います。

```bash
gemini --prompt "WebSearch: <query>"
```

## 方針

- 実行前に `python utility/check_env.py` を実行する。
- ローカル開発の依存関係の正本は `environment.yml`。`requirements.txt` は主に CI / 互換用途として扱う。
- 変化しやすい情報は、回答直前に検索し直す。
- 公式ドキュメントと一次情報を優先する。
- 検索結果を回答に使うときは、可能な範囲で出典 URL を含める。

## 例

```bash
gemini --prompt "WebSearch: OpenAI API documentation responses api"
gemini --prompt "WebSearch: GitHub Actions reusable workflows docs"
gemini --prompt "WebSearch: Cursor project rules mdc docs"
```

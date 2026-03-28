# Development Workflow

- Before executing project code, run `python utility/check_env.py`.
- Treat `environment.yml` as the source of truth for local development dependencies. `requirements.txt` is mainly for CI or compatibility paths.
- Use TDD where practical: write or update the failing test first, then implement the smallest fix, then refactor.
- Keep changes small and verify behavior with the narrowest useful test command first.

## Python Checks

- Run only the commands that match files that actually exist in the current project state.
- Typical test command once tests exist: `python -m pytest tests/ -v`
- Typical coverage command once `src/` exists: `python -m pytest tests/ --cov=src --cov-report=html`
- Typical lint/format/type-check commands once `src/` exists: `flake8 src/ --max-line-length=88`, `black src/`, `mypy src/`

## Search Workflow

- When using Gemini CLI for web search, call it as `gemini --prompt "WebSearch: <query>"`.
- In Claude Code or Codex sessions, built-in web search is acceptable when source URLs are included.

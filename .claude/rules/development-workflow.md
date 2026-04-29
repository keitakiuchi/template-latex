# Development Workflow

- Before executing project code, run `python utility/check_env.py`.
- Treat `environment.yml` as the source of truth for local development dependencies. `requirements.txt` is mainly for CI or compatibility paths.
- Use TDD where practical: write or update the failing test first, then implement the smallest fix, then refactor.
- Keep changes small and verify behavior with the narrowest useful test command first.
- Do not silently skip or partially execute heavy processing. If a task is too heavy to run reasonably in-session, ask the user to run the required command or steps instead.
- For long-running processing, prefer implementations that emit visible console progress so the user can tell the work is advancing.
- If a required package or dependency is missing, do not avoid using it by switching to a substitute package or alternate implementation on your own. First try to install it according to `environment.yml`, `README.md`, or the tool's standard installation path. If permissions, network access, or execution-environment constraints prevent you from installing it yourself, ask the user to install it and provide the exact package name and recommended command. Use a substitute package or alternate implementation only after explicit user approval.
- Do not suppress warnings on your own. Ask for user approval before silencing them.
- Do not add fallbacks on your own. Ask for user approval before introducing one.
- In LLM-related implementations, do not add classical NLP-based rule implementations unless the user explicitly approves that design.
- If statistical analysis is taking too long, do not quietly reduce settings to get it to finish. Ask the user before lowering sample counts, iterations, search space, precision, or similar parameters.

## Python Checks

- Run only the commands that match files that actually exist in the current project state.
- Typical test command once tests exist: `python -m pytest tests/ -v`
- Typical coverage command once `src/` exists: `python -m pytest tests/ --cov=src --cov-report=html`
- Typical lint/format/type-check commands once `src/` exists: `flake8 src/ --max-line-length=88`, `black src/`, `mypy src/`

## Search Workflow

- When using Gemini CLI for web search, call it as `gemini --prompt "WebSearch: <query>"`.
- In Claude Code or Codex sessions, built-in web search is acceptable when source URLs are included.

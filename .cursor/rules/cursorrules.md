# Cursor AI-Driven Coding Rules

1. Begin sessions by running `python utility/start.py` (or `INSTALL_DEPS=true ./utility/start.sh`) to validate the toolchain.
2. Follow `ai-driven-coding.md` for cross-agent coordination. Keep `plan/` for task breakdowns and commit any durable artefacts or decisions there.
3. Keep LaTeX edits inside `tex/` and graphics in `figures/`. Use `scripts/compile.sh` or the VS Code tasks for builds.
4. Prefer automated testing before shipping changes: `utility/check_env.py` for environment sanity, and `./scripts/compile.sh` for LaTeX regression checks.
5. Store experiment outputs in `workbench/` and long-lived reports in `results/`. Leave a `.gitkeep` file if directories would otherwise be empty.
6. Document AI assistance usage in pull requests by referencing the agent and prompts that produced the changes.

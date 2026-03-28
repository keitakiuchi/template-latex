# Claude Code Mapping

- Shared Claude Code runtime configuration lives in `.claude/settings.json`.
- Shared Claude Code skills live in `.claude/skills/`.
- Shared slash commands live in `.claude/commands/`.
- Shared subagents live in `.claude/agents/`.
- Hook scripts referenced from settings live in `.claude/hooks/`.
- This repository keeps `.claude/claude.yml` as a legacy project asset for compatibility. Claude Code's official project configuration path is `CLAUDE.md` plus `.claude/settings.json`.

## Rule Loading

- `.claude/rules/` is used in this project for modular shared instructions.
- Rule files are imported from `CLAUDE.md` using official `@path/to/file.md` imports.
- Keep each rule focused on one topic and use descriptive file names.
- For personal-only additions, prefer `~/.claude/CLAUDE.md` or `.claude/settings.local.json`.
- Use skills for task-specific instructions that should load only on demand.

## Feature Mapping

- Claude Code supports both `.claude/skills/` and `.claude/commands/`.
- Prefer `.claude/skills/` for reusable workflows that need supporting files, auto-discovery, or subagent execution.
- Keep `.claude/commands/` for lightweight one-file slash commands and backward compatibility. Existing command files continue to work, but skills are the preferred modern path.
- Use `.claude/agents/` for reusable specialist personas that skills or the main session can delegate to.
- Keep personal-only preferences in `~/.claude/CLAUDE.md` or `.claude/settings.local.json`, not in shared project files.

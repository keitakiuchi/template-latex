# Security

- Do not expose secrets, API keys, or `.env` contents in prompts, logs, or commits.
- Prefer environment variables for secrets and credentials.
- Validate external input and avoid unsafe shell composition.
- Treat destructive shell commands and force-push operations as high risk.

## Repository Guardrails

- Sensitive files are blocked in `.claude/settings.json` with `permissions.deny`.
- Bash commands are filtered through `.claude/hooks/bash-firewall.sh` before execution.
- Prefer the `security-auditor` subagent when working on auth, credentials, network calls, or deployment-sensitive changes.

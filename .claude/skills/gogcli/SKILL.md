---
name: gogcli
description: Use when working with the gog CLI for Gmail, Calendar, Drive, Docs, Sheets, Contacts, Tasks, Chat, Classroom, or other Google Workspace automation from the terminal. Also use when the user explicitly mentions gogcli or the gog command.
user-invocable: true
---

# gogcli

This is a local wrapper skill for `steipete/gogcli`, based on the upstream repository docs and repository guidelines.

Use @AUTH.md before helping with account setup, OAuth, tokens, or client credentials.
Use @COMMANDS.md when the task is about day-to-day `gog` usage.

## Operating Rules

1. Check whether `gog` is available before suggesting concrete terminal usage.
2. Prefer `gog --json` for automation or any result that will be parsed by tools.
3. Keep stdout parseable and avoid mixing human explanations into command pipelines.
4. Treat OAuth client JSON, refresh tokens, and keyring passwords as secrets. Never print or commit them.
5. If a requested operation is destructive or sends data externally, make that explicit before running it.

## Workflow

1. Confirm whether the task is setup, auth, read-only querying, or mutating data.
2. For setup/auth tasks, follow @AUTH.md.
3. For usage tasks, choose the narrowest relevant command family from @COMMANDS.md.
4. Prefer account selection via `--account` or `GOG_ACCOUNT` instead of assuming the default account.
5. For scripts and agents, prefer `--json` and document any required scopes.

## Safety Notes

- `gog` can send mail, modify calendar events, edit Drive files, and change Workspace state.
- Read-only variants and narrow scopes are preferable when the user does not need write access.
- If `gog` is not installed, say so plainly and stop before inventing output.

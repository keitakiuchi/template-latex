---
description: Review the current working tree for bugs, regressions, and missing tests
allowed-tools: Bash(git status), Bash(git diff), Bash(git diff *), Bash(git diff --cached), Bash(git diff --cached *), Read, Grep, Glob
argument-hint: [focus]
---

Review the current working tree.

Focus areas:
- Bugs and behavioral regressions
- Security or secret-handling mistakes
- Missing tests
- Risky assumptions in configs or scripts

Additional review focus from the user: $ARGUMENTS

Start by checking `git status`, then inspect both staged and unstaged diff.
Prefer concrete findings over style commentary.

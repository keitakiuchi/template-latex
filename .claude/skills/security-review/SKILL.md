---
name: security-review
description: Review the current repository state for secrets exposure, unsafe shell usage, input validation gaps, auth mistakes, and deployment-sensitive risks. Use when the user asks for a security review or before merging sensitive changes.
context: fork
agent: security-auditor
allowed-tools: Read, Grep, Glob, Bash(git status), Bash(git diff), Bash(git diff *), Bash(git diff --cached), Bash(git diff --cached *)
---

# Security Review

Use @CHECKLIST.md as the audit checklist.

1. Start with `git status`.
2. Review staged and unstaged diff.
3. Focus on changed files first, then inspect nearby call sites or configs when needed.
4. Report only concrete issues or explicit residual risks.

Output format:
- Severity
- Why it matters
- File or area
- Recommended remediation

If no material issue is found, say so directly and mention any testing or coverage gap.

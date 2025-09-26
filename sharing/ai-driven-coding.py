#!/usr/bin/env python3
"""Utility helpers for AI-driven coding policies.

Running this script prints the locations of the rule documents so team members
can audit them quickly. Future enhancements can aggregate or validate content.
"""

from __future__ import annotations

import pathlib

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]

RULE_FILES = {
    "Claude": REPO_ROOT / "CLAUDE.md",
    "Gemini": REPO_ROOT / "GEMINI.md",
    "OpenAI Codex Playbook": REPO_ROOT / "AGENTS.md",
    "Codex CLI/IDE": REPO_ROOT / ".codex" / "config.toml",
    "Repository Playbook": REPO_ROOT / "ai-driven-coding.md",
    "Cursor Rules": REPO_ROOT / ".cursor" / "rules" / "cursorrules.md",
}


def main() -> None:
    print("AI-driven coding rule files:")
    for name, path in RULE_FILES.items():
        status = "found" if path.exists() else "missing"
        print(f"- {name:<18} : {path.relative_to(REPO_ROOT)} ({status})")

    plan_dir = REPO_ROOT / "plan"
    results_dir = REPO_ROOT / "results"
    print()
    print("Shared directories:")
    print(f"- plan      : {plan_dir.relative_to(REPO_ROOT)}")
    print(f"- results   : {results_dir.relative_to(REPO_ROOT)}")
    print(f"- workbench : {(REPO_ROOT / 'workbench').relative_to(REPO_ROOT)}")


if __name__ == "__main__":  # pragma: no cover
    main()

#!/usr/bin/env python3
"""Validate the local environment for the LaTeX template project."""

from __future__ import annotations

import shutil
import sys
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parent.parent
REQUIRED_DIRECTORIES = [
    PROJECT_ROOT / "tex",
    PROJECT_ROOT / "tex" / "sections",
    PROJECT_ROOT / "tex" / "bib",
    PROJECT_ROOT / "figures",
    PROJECT_ROOT / "build" / "pdf",
    PROJECT_ROOT / ".claude",
    PROJECT_ROOT / ".claude" / "commands",
    PROJECT_ROOT / ".cursor" / "rules",
    PROJECT_ROOT / ".github" / "workflows",
    PROJECT_ROOT / ".codex",
    PROJECT_ROOT / "utility",
    PROJECT_ROOT / "sharing",
    PROJECT_ROOT / "plan",
    PROJECT_ROOT / "results",
    PROJECT_ROOT / "workbench",
]
REQUIRED_FILES = [
    PROJECT_ROOT / "tex" / "main.tex",
    PROJECT_ROOT / "tex" / "preamble.tex",
    PROJECT_ROOT / "tex" / "bib" / "refs.bib",
    PROJECT_ROOT / "scripts" / "compile.sh",
    PROJECT_ROOT / "latexmkrc",
    PROJECT_ROOT / ".claude" / "claude.yml",
    PROJECT_ROOT / ".claude" / "commands" / "gemini-search.md",
    PROJECT_ROOT / ".codex" / "config.toml",
    PROJECT_ROOT / ".cursor" / "rules" / "cursorrules.md",
    PROJECT_ROOT / "AGENTS.md",
    PROJECT_ROOT / "CLAUDE.md",
    PROJECT_ROOT / "GEMINI.md",
    PROJECT_ROOT / "environment.yml",
    PROJECT_ROOT / "sharing" / "ai-driven-coding.py",
    PROJECT_ROOT / "sharing" / "ai-driven-coding.md",
]
LATEX_COMMANDS = ("latexmk", "lualatex")


def header(title: str) -> None:
    print("=" * 70)
    print(title)
    print("=" * 70)


def check_virtual_environment() -> None:
    inside_env = sys.prefix != getattr(sys, "base_prefix", sys.prefix)
    status = "OK" if inside_env else "WARN"
    message = "Virtual environment detected" if inside_env else "Virtual environment not detected"
    print(f"[{status}] {message}")


def check_directories() -> None:
    for path in REQUIRED_DIRECTORIES:
        if path.exists():
            print(f"[OK] Directory exists: {path.relative_to(PROJECT_ROOT)}")
        else:
            print(f"[FAIL] Missing directory: {path.relative_to(PROJECT_ROOT)}")


def check_files() -> None:
    for path in REQUIRED_FILES:
        if path.exists():
            print(f"[OK] File exists: {path.relative_to(PROJECT_ROOT)}")
        else:
            print(f"[FAIL] Missing file: {path.relative_to(PROJECT_ROOT)}")


def check_commands() -> None:
    for command in LATEX_COMMANDS:
        resolved = shutil.which(command)
        if resolved:
            print(f"[OK] {command} available at {resolved}")
        else:
            print(f"[FAIL] {command} is not available in PATH")


def main() -> None:
    header("LaTeX Environment Check")
    check_virtual_environment()
    check_directories()
    check_files()
    check_commands()
    print("=" * 70)
    print("Environment check finished.")
    print("=" * 70)


if __name__ == "__main__":
    main()

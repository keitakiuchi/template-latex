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
    PROJECT_ROOT / "AGENTS.md",
    PROJECT_ROOT / "CLAUDE.md",
    PROJECT_ROOT / "GEMINI.md",
    PROJECT_ROOT / "environment.yml",
    PROJECT_ROOT / "sharing" / "ai-driven-coding.py",
    PROJECT_ROOT / "sharing" / "ai-driven-coding.md",
]
REQUIRED_GLOBS = [
    (PROJECT_ROOT / ".cursor" / "rules", "*.mdc", "Cursor rule files"),
]
LATEX_COMMANDS = ("latexmk", "lualatex")


def header(title: str) -> None:
    print("=" * 70)
    print(title)
    print("=" * 70)


def check_virtual_environment() -> int:
    inside_env = sys.prefix != getattr(sys, "base_prefix", sys.prefix)
    status = "OK" if inside_env else "WARN"
    message = "Virtual environment detected" if inside_env else "Virtual environment not detected"
    print(f"[{status}] {message}")
    return 0


def check_directories() -> int:
    failures = 0
    for path in REQUIRED_DIRECTORIES:
        if path.is_dir():
            print(f"[OK] Directory exists: {path.relative_to(PROJECT_ROOT)}")
        else:
            print(f"[FAIL] Missing directory: {path.relative_to(PROJECT_ROOT)}")
            failures += 1
    return failures


def check_files() -> int:
    failures = 0
    for path in REQUIRED_FILES:
        if path.is_file():
            print(f"[OK] File exists: {path.relative_to(PROJECT_ROOT)}")
        else:
            print(f"[FAIL] Missing file: {path.relative_to(PROJECT_ROOT)}")
            failures += 1
    return failures


def check_globs() -> int:
    failures = 0
    for directory, pattern, label in REQUIRED_GLOBS:
        matches = sorted(directory.glob(pattern))
        if matches:
            print(f"[OK] {label} found in: {directory.relative_to(PROJECT_ROOT)}")
        else:
            print(
                f"[FAIL] No {label.lower()} found in: {directory.relative_to(PROJECT_ROOT)}"
            )
            failures += 1
    return failures


def check_commands() -> int:
    failures = 0
    for command in LATEX_COMMANDS:
        resolved = shutil.which(command)
        if resolved:
            print(f"[OK] {command} available at {resolved}")
        else:
            print(f"[FAIL] {command} is not available in PATH")
            failures += 1
    return failures


def main() -> int:
    header("LaTeX Environment Check")
    failures = 0
    failures += check_virtual_environment()
    failures += check_directories()
    failures += check_files()
    failures += check_globs()
    failures += check_commands()
    print("=" * 70)
    if failures:
        print(f"Environment check finished with {failures} failure(s).")
    else:
        print("Environment check finished successfully.")
    print("=" * 70)
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())

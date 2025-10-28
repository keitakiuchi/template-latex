#!/usr/bin/env python3
"""Replicate the root ai-driven-coding template with project-specific values."""

from __future__ import annotations

import sys
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[1]
SOURCE = PROJECT_ROOT / "ai-driven-coding.md"
TARGET = PROJECT_ROOT / "sharing" / "ai-driven-coding.md"

REPLACEMENTS = {
    "<your-project-name>": "template-latex",
    "conda activate env-example": "conda activate latex-template",
}


def main() -> int:
    if not SOURCE.exists():
        print(f"[ERROR] Source template not found: {SOURCE}")
        return 1

    text = SOURCE.read_text(encoding="utf-8")
    for placeholder, value in REPLACEMENTS.items():
        text = text.replace(placeholder, value)

    TARGET.write_text(text, encoding="utf-8")
    print(f"[INFO] Updated {TARGET.relative_to(PROJECT_ROOT)} using {SOURCE.name}")
    return 0


if __name__ == "__main__":
    sys.exit(main())

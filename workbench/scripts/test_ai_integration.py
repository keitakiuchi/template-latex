#!/usr/bin/env python3
"""Smoke test helpers for experimenting with the LaTeX toolchain."""

from __future__ import annotations

import json
import subprocess
from datetime import datetime
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[2]
RESULTS_FILE = PROJECT_ROOT / "workbench" / "results" / "latex_build_check.json"


def run_command(command: list[str]) -> dict[str, object]:
    try:
        completed = subprocess.run(
            command,
            cwd=PROJECT_ROOT,
            check=True,
            capture_output=True,
            text=True,
        )
        return {
            "command": " ".join(command),
            "returncode": completed.returncode,
            "stdout": completed.stdout,
            "stderr": completed.stderr,
            "timestamp": datetime.utcnow().isoformat(),
        }
    except FileNotFoundError as error:
        return {
            "command": " ".join(command),
            "error": f"command not found: {error}",
            "timestamp": datetime.utcnow().isoformat(),
        }
    except subprocess.CalledProcessError as error:
        return {
            "command": " ".join(command),
            "returncode": error.returncode,
            "stdout": error.stdout,
            "stderr": error.stderr,
            "timestamp": datetime.utcnow().isoformat(),
        }


def main() -> None:
    tex_commands = [
        ["latexmk", "-version"],
        ["lualatex", "--version"],
        ["bash", "scripts/compile.sh", "main"],
    ]

    results = {
        "generated_at": datetime.utcnow().isoformat(),
        "checks": [run_command(cmd) for cmd in tex_commands],
    }

    RESULTS_FILE.parent.mkdir(parents=True, exist_ok=True)
    RESULTS_FILE.write_text(json.dumps(results, indent=2))


if __name__ == "__main__":
    main()

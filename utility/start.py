#!/usr/bin/env python3
"""Bootstrap helper for the template-latex repository.

The script performs three tasks:
  1. validates the working directory,
  2. optionally installs Python dependencies, and
  3. runs the environment checks.

Usage examples:
  python utility/start.py              # run checks only
  python utility/start.py --install    # install requirements then run checks
"""

from __future__ import annotations

import argparse
import pathlib
import subprocess
import sys

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]


def run_command(command: list[str]) -> int:
    print(f"$ {' '.join(command)}")
    return subprocess.call(command)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Set up template-latex tooling.")
    parser.add_argument(
        "--install",
        action="store_true",
        help="Install Python dependencies with pip before running checks.",
    )
    parser.add_argument(
        "--python",
        default=sys.executable,
        help="Python executable to use (defaults to the current interpreter).",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()

    if pathlib.Path.cwd() != REPO_ROOT:
        print("[WARN] Run this script from the repository root for consistent paths.")
        print(f"        Detected: {pathlib.Path.cwd()}")
        print(f"        Expected: {REPO_ROOT}")

    if args.install:
        requirements = REPO_ROOT / "requirements.txt"
        if requirements.exists():
            rc = run_command([args.python, "-m", "pip", "install", "-r", str(requirements)])
            if rc != 0:
                print("[ERROR] pip install failed. Resolve the issue before continuing.")
                sys.exit(rc)
        else:
            print("[WARN] requirements.txt not found; skipping dependency installation.")

    rc = run_command([args.python, str(REPO_ROOT / "utility" / "check_env.py")])
    if rc != 0:
        sys.exit(rc)

    print()
    print("Setup complete. Refer to ai-driven-coding.md for the next steps.")


if __name__ == "__main__":  # pragma: no cover
    main()

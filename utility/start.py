#!/usr/bin/env python3
"""Bootstrap helper for the LaTeX template project."""

from __future__ import annotations

import shutil
import subprocess
import sys
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parent.parent
DIRECTORIES_TO_CREATE = [
    PROJECT_ROOT / "figures",
    PROJECT_ROOT / "workbench" / "results",
    PROJECT_ROOT / "results",
]
ENV_FILE = PROJECT_ROOT / "environment.yml"
ENV_NAME = "latex-template"


def header(title: str) -> None:
    print("=" * 70, flush=True)
    print(title, flush=True)
    print("=" * 70, flush=True)


def create_directories() -> None:
    for path in DIRECTORIES_TO_CREATE:
        created = False
        if not path.exists():
            path.mkdir(parents=True, exist_ok=True)
            created = True
        status = "CREATED" if created else "OK"
        print(f"[{status}] {path.relative_to(PROJECT_ROOT)}", flush=True)


def report_environment_manifest() -> None:
    if ENV_FILE.exists():
        print(f"[OK] Found environment file: {ENV_FILE.relative_to(PROJECT_ROOT)}", flush=True)
    else:
        print("[WARN] environment.yml is missing; create it to manage the Python toolchain.", flush=True)


def report_conda_status() -> None:
    conda_path = shutil.which("conda")
    if not conda_path:
        print("[WARN] conda executable not found; skipping environment sync guidance.", flush=True)
        return

    if not ENV_FILE.exists():
        print("[WARN] environment.yml not present; run `conda env export` after creating one.", flush=True)
        return

    try:
        result = subprocess.run(
            [conda_path, "env", "list"],
            capture_output=True,
            text=True,
            check=True,
        )
    except subprocess.CalledProcessError as error:
        print(f"[WARN] Unable to list conda environments ({error.returncode}); consult conda logs.", flush=True)
        return

    exists = any(line.split()[0] == ENV_NAME for line in result.stdout.splitlines() if line.strip())
    if exists:
        print(
            f"[INFO] Conda environment '{ENV_NAME}' detected. "
            f"Update with: conda env update --file environment.yml --name {ENV_NAME}",
            flush=True,
        )
    else:
        print(
            f"[INFO] Conda environment '{ENV_NAME}' not found. "
            f"Create with: conda env create --file environment.yml --name {ENV_NAME}",
            flush=True,
        )
    print(f"[INFO] Activate with: conda activate {ENV_NAME}", flush=True)


def run_environment_check() -> None:
    check_env_path = PROJECT_ROOT / "utility" / "check_env.py"
    if not check_env_path.exists():
        print("[WARN] utility/check_env.py not found; skipping environment check.", flush=True)
        return

    print("[INFO] Running utility/check_env.py", flush=True)
    try:
        subprocess.run(
            [sys.executable, str(check_env_path)],
            cwd=PROJECT_ROOT,
            check=True,
        )
    except subprocess.CalledProcessError as error:
        print(f"[WARN] Environment check exited with {error.returncode}. See output above.", flush=True)
    except FileNotFoundError:
        print("[WARN] Python executable not found; skipping environment check.", flush=True)


def main() -> None:
    header("LaTeX Project Bootstrap")
    create_directories()
    report_environment_manifest()
    report_conda_status()
    run_environment_check()
    print("=" * 70, flush=True)
    print("Next steps:", flush=True)
    print("  - Install TeX Live or MacTeX with latexmk and lualatex.", flush=True)
    print("  - Build via ./scripts/compile.sh or VS Code LaTeX Workshop.", flush=True)
    print("  - Keep environment.yml in sync and rerun utility/check_env.py after changes.", flush=True)
    print("=" * 70, flush=True)


if __name__ == "__main__":
    sys.exit(main())

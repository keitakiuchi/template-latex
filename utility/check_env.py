#!/usr/bin/env python3
"""Basic environment checks for the template-latex project."""

from __future__ import annotations

import pathlib
import shutil
import sys
from typing import Dict, Iterable, Tuple

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]
TEX_DIR = REPO_ROOT / "tex"
REQUIRED_TOOLS: Dict[str, str] = {
    "latexmk": "Install latexmk (TeX Live) to run the build scripts.",
    "lualatex": "Install LuaLaTeX. TeX Live full install includes it.",
}
OPTIONAL_TOOLS: Dict[str, str] = {
    "biber": "Needed when bibliographies are in use.",
}


def check_command(name: str) -> Tuple[bool, str]:
    location = shutil.which(name)
    return location is not None, location or ""


def check_path(path: pathlib.Path) -> bool:
    return path.exists()


def report(label: str, status: str, details: str | None = None) -> None:
    print(f"[{status}] {label}")
    if details:
        print(f"        {details}")


def summarize(results: Iterable[bool]) -> None:
    all_ok = all(results)
    print()
    if all_ok:
        print("Environment check passed.")
        sys.exit(0)
    print("Environment check failed. Review the items marked [FAIL].")
    sys.exit(1)


def main() -> None:
    results = []

    repo_ok = check_path(REPO_ROOT / "latexmkrc") and check_path(TEX_DIR / "main.tex")
    report("Repository layout", "OK" if repo_ok else "FAIL", "Expected latexmkrc and tex/main.tex present")
    results.append(repo_ok)

    figures_ok = check_path(REPO_ROOT / "figures")
    report("Figures directory", "OK" if figures_ok else "FAIL", "Create figures/ when adding assets")
    results.append(figures_ok)

    for tool, help_text in REQUIRED_TOOLS.items():
        ok, location = check_command(tool)
        report(
            f"Tool available: {tool}",
            "OK" if ok else "FAIL",
            location if ok else help_text,
        )
        results.append(ok)

    for tool, help_text in OPTIONAL_TOOLS.items():
        ok, location = check_command(tool)
        status = "OK" if ok else "WARN"
        report(
            f"Optional tool: {tool}",
            status,
            location if ok else help_text,
        )

    python_ok = sys.version_info >= (3, 10)
    report("Python version >= 3.10", "OK" if python_ok else "FAIL", f"Detected {sys.version.split()[0]}")
    results.append(python_ok)

    requirements = REPO_ROOT / "requirements.txt"
    requirements_ok = check_path(requirements)
    report(
        "Python requirements",
        "OK" if requirements_ok else "FAIL",
        "requirements.txt missing" if not requirements_ok else str(requirements),
    )
    results.append(requirements_ok)

    summarize(results)


if __name__ == "__main__":  # pragma: no cover
    main()

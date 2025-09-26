#!/usr/bin/env bash
# Bootstrap helper for template-latex. Mirrors utility/start.py in Bash.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
PYTHON_BIN="${PYTHON_BIN:-python3}"
INSTALL_DEPS="${INSTALL_DEPS:-false}"

cd "$REPO_ROOT"

echo "Repo root: $REPO_ROOT"

echo "Using Python: $PYTHON_BIN"
if [[ "$INSTALL_DEPS" == "true" ]]; then
  if [[ -f requirements.txt ]]; then
    echo "Installing Python dependencies..."
    "$PYTHON_BIN" -m pip install -r requirements.txt
  else
    echo "requirements.txt not found; skipping pip install"
  fi
else
  echo "Skipping pip install (set INSTALL_DEPS=true to enable)."
fi

echo
echo "Running environment checks..."
"$PYTHON_BIN" utility/check_env.py

echo
echo "Bootstrap complete. Review ai-driven-coding.md for additional guidance."

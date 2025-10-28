#!/usr/bin/env bash
# Bootstrap helper for the LaTeX template project.

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

ENV_NAME="latex-template"
ENV_FILE="$PROJECT_ROOT/environment.yml"

header() {
  echo "======================================================================"
  echo "$1"
  echo "======================================================================"
}

header "LaTeX Project Bootstrap (utility/start.sh)"

create_dir() {
  local path="$1"
  if [[ -d "$path" ]]; then
    echo "[OK] ${path#$PROJECT_ROOT/}"
  else
    mkdir -p "$path"
    echo "[CREATED] ${path#$PROJECT_ROOT/}"
  fi
}

create_dir "$PROJECT_ROOT/figures"
create_dir "$PROJECT_ROOT/workbench/results"
create_dir "$PROJECT_ROOT/results"

if [[ -f "$ENV_FILE" ]]; then
  echo "[OK] environment.yml found"
else
  echo "[WARN] environment.yml not found; create one to manage the Python toolchain."
fi

if command -v conda >/dev/null 2>&1; then
  if [[ -f "$ENV_FILE" ]]; then
    if conda env list | awk '{print $1}' | grep -qx "$ENV_NAME"; then
      echo "[INFO] Conda environment '$ENV_NAME' detected."
      echo "       Update with: conda env update --file environment.yml --name $ENV_NAME"
    else
      echo "[INFO] Conda environment '$ENV_NAME' not found."
      echo "       Create with: conda env create --file environment.yml --name $ENV_NAME"
    fi
    echo "       Activate with: conda activate $ENV_NAME"
  fi
else
  echo "[WARN] conda executable not found; skipping environment sync guidance."
fi

if command -v python3 >/dev/null 2>&1; then
  echo "[INFO] Running utility.check_env"
  python3 "$PROJECT_ROOT/utility/check_env.py" || echo "[WARN] Environment check reported issues."
else
  echo "[WARN] python3 not found; skipping environment check."
fi

header "Next steps"
echo "  - Install TeX Live or MacTeX with latexmk and lualatex."
echo "  - Build via ./scripts/compile.sh or VS Code LaTeX Workshop."
echo "  - Re-run utility/check_env.py after updating your toolchain."
echo "======================================================================"

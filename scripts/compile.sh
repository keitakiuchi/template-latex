#!/usr/bin/env bash
# Wrapper to maintain legacy compile entrypoint for AI integrations.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

exec "${SCRIPT_DIR}/02_compile.sh" "$@"

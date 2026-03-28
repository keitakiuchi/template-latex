#!/usr/bin/env bash
set -euo pipefail

python3 -c '
import json
import re
import sys

BLOCKED_PATTERNS = [
    (r"(^|\s)rm\s+-rf\s+/", "Blocked destructive command: rm -rf /"),
    (r"(^|\s)sudo\s+rm\b", "Blocked destructive command: sudo rm"),
    (r"(^|\s)git\s+push\b.*--force\b", "Blocked force push command"),
    (r"(^|\s)curl\b.*\|\s*(bash|sh)\b", "Blocked pipe-to-shell command: curl | bash/sh"),
    (r"(^|\s)wget\b.*\|\s*(bash|sh)\b", "Blocked pipe-to-shell command: wget | bash/sh"),
    (r"(^|\s)(curl|wget)\b.*(?:&&|;)\s*(bash|sh)\b", "Blocked download-then-shell command"),
    (r"\bDROP\s+TABLE\b", "Blocked SQL destructive command: DROP TABLE"),
]

try:
    data = json.load(sys.stdin)
except json.JSONDecodeError as exc:
    print(f"Failed to parse hook input: {exc}", file=sys.stderr)
    sys.exit(1)

if data.get("tool_name") != "Bash":
    sys.exit(0)

command = data.get("tool_input", {}).get("command", "")
if not command:
    sys.exit(0)

for pattern, message in BLOCKED_PATTERNS:
    if re.search(pattern, command, flags=re.IGNORECASE):
        print(message, file=sys.stderr)
        print(f"Command: {command}", file=sys.stderr)
        sys.exit(2)

sys.exit(0)
'

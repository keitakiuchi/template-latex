# Security Review Checklist

- Secrets or credentials added to code, config, logs, or examples
- `.env` or credential file reads introduced by scripts or tooling
- Unsafe shell execution, especially `curl | bash`, `wget | sh`, or unchecked command interpolation
- Missing validation or sanitization on external input
- Authentication or authorization regressions
- Overly broad permissions in CI, automation, or deployment scripts
- Risky network access, secret propagation, or plaintext storage
- Missing tests around security-sensitive paths

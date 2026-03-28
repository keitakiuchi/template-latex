# gogcli Auth

Use this when the task is about initial setup, credentials, OAuth, tokens, or account selection.

## Prerequisites

- The user needs Google Cloud OAuth client credentials for a Desktop app.
- The necessary Google APIs must be enabled for the services they plan to use.
- OAuth client JSON files and tokens must be treated as secrets.

## Baseline Setup

1. Store OAuth client credentials:
   `gog auth credentials /path/to/client_secret.json`
2. Authorize an account:
   `gog auth add you@example.com`
3. Verify auth:
   `gog auth status`
4. Optional: list accounts:
   `gog auth list`

## Multi-Client Setup

- Named clients are supported with `--client`.
- Example:
  `gog --client work auth credentials /path/to/work-client.json`
  `gog --client work auth add you@company.com`

## Account Selection

- Use `--account <email|alias|auto>` for one-off commands.
- Use `GOG_ACCOUNT` when multiple related commands should target the same account.
- Avoid assuming the default account in multi-account environments.

## Scope Guidance

- Request the fewest scopes possible.
- For targeted access:
  `gog auth add you@example.com --services drive,calendar`
- For read-only usage:
  `gog auth add you@example.com --services drive,calendar --readonly`
- For narrower Drive/Gmail scopes, use `--drive-scope` and `--gmail-scope`.

## Headless Notes

- `gog` supports manual and remote flows for machines without a local browser.
- Direct access tokens are possible with `--access-token`, but they expire and do not auto-refresh.

## Secret Handling

- Never commit OAuth client JSON files.
- Never expose refresh tokens or keyring passwords.
- Prefer OS keychain storage when available.

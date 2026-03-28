# gogcli Commands

Use this when the user wants to query or automate Google services via `gog`.

## General Rules

- Prefer `gog --json ...` for agentic workflows or piping into `jq`.
- For human-readable ad hoc use, default text output is fine.
- Keep stderr/stdout behavior in mind when composing pipelines.

## Common Patterns

### Gmail

- List labels:
  `gog gmail labels list`
- Search recent mail:
  `gog --json gmail search 'newer_than:7d' --max 20`
- Message-level search:
  `gog --json gmail messages search 'from:alice@example.com newer_than:30d' --max 20`

### Calendar

- Check free/busy:
  `gog --json calendar freebusy --calendars primary --from 2026-03-28T00:00:00Z --to 2026-03-29T00:00:00Z`
- Create an event:
  `gog calendar create primary --summary "Team Standup" --from 2026-03-28T10:00:00Z --to 2026-03-28T10:30:00Z`

### Drive

- Search files:
  `gog --json drive search 'invoice filetype:pdf' --max 20`
- Download a file:
  `gog drive download <fileId>`

### Docs / Sheets / Slides

- Export a Doc:
  `gog docs export <docId> --format pdf --out ./doc.pdf`
- Export a Sheet:
  `gog sheets export <spreadsheetId> --format pdf`
- Export Slides:
  `gog slides export <presentationId> --format pptx --out ./deck.pptx`

### Contacts / Tasks

- Search contacts:
  `gog --json contacts search 'Alice'`
- List tasklists:
  `gog --json tasks lists`

## Scripting Guidance

- Prefer:
  `gog --json ... | jq ...`
- Example:
  `gog --json drive search 'invoice filetype:pdf' --max 20 | jq -r '.files[].id'`

## Mutation Safety

- Sending mail, editing Docs, changing events, deleting tasks, or modifying permissions should be treated as write operations.
- Make the target account and intended side effects explicit before execution.

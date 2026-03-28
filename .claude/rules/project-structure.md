# Project Structure

- Source code belongs under `src/` or `app/`.
- Tests belong under `tests/`.
- Configuration belongs under `config/`.
- Utility scripts belong under `utility/`.
- This repository is itself a template, so these directories may not exist yet; create them when adding real project code.

## Analysis Directories

- `workbench/`: throwaway experiments and temporary scratch work
- `analysis_steps/`: reproducible analysis steps and intermediate process docs
- `results/`: durable outputs, reports, and final artifacts

## Placement Rules

- New application logic should not be added at the repository root.
- Keep project-specific helpers out of global config files when they belong in `src/`, `app/`, or `utility/`.
- Prefer descriptive lowercase file names with hyphen or underscore separators.

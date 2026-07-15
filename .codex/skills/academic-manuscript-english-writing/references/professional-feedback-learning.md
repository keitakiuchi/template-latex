# Learning from Professional Editing Feedback

Use this reference when the user supplies professionally edited manuscripts to improve this skill, asks to learn recurring rules from tracked changes or comments, or asks for a self-proofreading process calibrated from prior professional feedback. Extract transferable rules without treating every editorial change as correct or universal.

## Contents

- Outputs
- Extract the Evidence
- Establish Evidence Independence
- Classify Each Candidate Lesson
- Evaluate Candidate Rules
- High-Risk Contrasts to Audit
- Update the Skill
- Forward Validation

## Outputs

Produce three internal result sets before editing the skill:

1. stable language rules suitable for `editor-feedback-checklist.md`;
2. contextual rules that belong to a genre, journal, discipline, or author-style profile; and
3. verify-only findings that identify scientific, statistical, or reporting risks but must not be converted into automatic rewrites.

Do not store manuscript passages, comments, editor names, or document-specific scientific content in the skill unless the user explicitly requests a retained corpus. Generalize examples and keep raw extraction in a temporary location.

## Extract the Evidence

For DOCX files with tracked changes or comments, run:

```bash
python scripts/extract_docx_editor_feedback.py \
  --format json \
  --output /tmp/docx-editor-feedback.json \
  proofed-file-1.docx proofed-file-2.docx
```

The script reconstructs original and revised paragraph text, retains Word's own revision units, reports text and formatting revisions separately, and links comments to their available original and revised anchors. It uses only the Python standard library.

Before running a skill script in a repository with environment instructions, satisfy those instructions first.

If a DOCX contains only clean final text, identify the exact pre-proof source and compare the pair. If later author revisions exist, use the three-way comparison required by `../SKILL.md`. Do not infer editor changes from a clean final file alone.

## Establish Evidence Independence

- Group successive rounds, journal variants, resubmissions, and title-page or formatting variants of the same underlying manuscript into one manuscript family.
- Count recurrence across manuscript families, editors, genres, and contexts. Do not treat seven versions of one passage as seven independent confirmations.
- Separate the editor's English comment from any machine-generated translation. Use the original comment as the evidence; use a translation only as an aid.
- Treat canned comments such as “improved flow” or “more native tone” as low-information labels. Infer the rule from the actual source-to-revision contrast and its sentence context.
- Inspect broad or empty comment anchors against the nearby tracked change. An anchor identifies location, not necessarily the exact reason for every edit in the range.
- Separate textual revisions, formatting revisions, moved text, journal-compliance changes, and content queries before counting patterns.

## Classify Each Candidate Lesson

Assign one primary class:

- **General language:** grammar, syntax, modifier scope, parallelism, concision, collocation, punctuation, or unambiguous reference.
- **Manuscript consistency:** spelling, hyphenation, capitalization, typography, abbreviations, labels, cross-references, or terminology selected for the current document.
- **Genre or venue:** abstract structure and length, heading levels, reference style, table placement, declarations, or submission components.
- **Domain terminology:** validated constructs, statistical expressions, instrument names, population descriptors, or field-specific collocations.
- **Author preference:** a repeated voice choice that remains optional under standard academic English.
- **Document-specific repair:** a local antecedent, comparison group, citation gap, section number, table value, or malformed sentence.
- **Substantive query:** a possible change to design, model interpretation, unit of analysis, independence, result direction, or claim strength.
- **Unsafe or erroneous edit:** an editorial change that introduces ambiguity, ungrammatical prose, factual drift, or an unsupported stronger claim.

Do not promote venue rules, author preferences, or one editor's spelling choice into universal language rules.

## Evaluate Candidate Rules

For each candidate, record internally:

```text
Issue:
Context:
Preferred action:
Meaning or scope to preserve:
Exceptions:
Self-check:
Evidence: direct rationale / repeated edit / authoritative convention
Independence: manuscript families and distinct contexts
Confidence: stable / contextual / tentative / reject
```

Promote a rule to the canonical checklist when at least one of these holds:

- the editor gives a clear rationale and the rule agrees with established academic English;
- the pattern recurs in distinct contexts or manuscript families and has a stable explanation; or
- the pattern exposes a high-risk meaning error that merits a mandatory self-check.

Keep a rule contextual when its correct form depends on journal style, English variety, grammatical position, disciplinary terminology, or intended modality. Reject a rule when it merely copies one surface substitution or conflicts with the source meaning.

## High-Risk Contrasts to Audit

Treat the following as meaning edits even when the revised prose is smoother:

- `must`, `should`, `need to`, `may`, `can`, `could`, and `would`;
- singular, plural, possessive, aggregate, and unit-of-analysis changes;
- `study`, `article`, `paper`, method, model, procedure, rating, observation, participant, script, and sample;
- causal versus associative verbs and confirmed outcomes versus flags or proxies;
- model descriptions such as ordinal versus continuous outcomes;
- independence claims and the noun attached to a sample size or statistic;
- changes to the grammatical subject that shift who or what performed, changed, measured, or supported something;
- title, abstract, main-text, table, and figure statements about the same design or result.

Convert these patterns into verification questions, not automatic replacements.

## Update the Skill

1. Add stable language and self-check rules to `editor-feedback-checklist.md` without duplicating existing rules.
2. Add genre-specific lessons to `genre-writing-guides.md` only when they remain useful beyond one journal; require current official verification for mutable venue requirements.
3. Add author-voice tendencies to a task-local style profile under `author-style-calibration.md`; do not hard-code them as universal rules.
4. Keep substantive findings as audit triggers. Do not encode a new scientific position, method, or estimand.
5. Update `../SKILL.md` routing only when the workflow or trigger conditions change.
6. Add or update tests when the DOCX extractor encounters a new OOXML structure.
7. Run the extractor tests and the skill validator after editing.

## Forward Validation

Validate new rules on passages or documents not used to derive them when practical. Look for both missed errors and overcorrection. A successful rule should improve clarity or correctness in a new context without changing modality, scope, terminology, statistics, or citation attribution.

If independent validation is unavailable, label the lesson contextual or tentative rather than presenting it as settled.

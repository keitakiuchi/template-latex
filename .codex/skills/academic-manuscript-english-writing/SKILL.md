---
name: academic-manuscript-english-writing
description: Draft, revise, and polish academic manuscript English for journal articles, abstracts, tables, figures, cover letters, and reviewer responses. Use when Codex needs to write or edit scholarly English for clarity, concision, formal tone, medical/scientific usage, abbreviation handling, balanced comparisons, article choice, compound modifiers, standard ethics/privacy or statistical terminology, collocations, prose based on professional English-editing feedback, or integration of proofed manuscript files while checking that scientific meaning and document structure are preserved.
---

# Write Academic English

## Core Workflow

1. Identify the target genre: title, abstract, manuscript body, table/figure legend, response letter, cover letter, or email.
2. Preserve the scientific meaning, study design, variables, units, statistics, and citation claims.
3. Rewrite toward formal academic English: concise wording, direct verbs, precise collocations, balanced comparisons, and clear modifier placement.
4. Check local journal style if supplied. If none is supplied, default to standard American academic English.
5. For edited text, provide a polished version first, then a short note on substantive changes when useful.

## Integrating Proofed Manuscripts

When applying professional edits from a proofed file to an existing manuscript:

1. Treat the proofed file as proposed edits, not as automatically authoritative.
2. Compare the proofed version against the source at the title, heading, paragraph, table, figure, and reference levels before overwriting the source.
3. Apply wording, grammar, concision, punctuation, and formatting improvements only when they preserve the intended scientific claim.
4. Reject or repair proofed edits that change constructs, population descriptors, study design, modality, tense tied to study status, statistical meaning, measurement terminology, or claim strength.
5. Preserve source-only structural content such as table panels, figure links, local asset paths, raw Markdown/OpenXML blocks, supplement references, and complete reference lists unless the user explicitly asks to convert or remove them.
6. After integration, run a final integrity pass for headings, tables, figures, references, citations, DOI/URL coverage, statistics, abbreviations, and domain terms.

## Manuscript Style Rules

- Prefer formal academic verbs and terms. Replace casual wording such as "give" with field-appropriate alternatives such as "administer" for dosage or interventions.
- Remove redundant initial articles from titles and headings when they add no meaning.
- Express ideas concisely. Replace wordy phrases with compact alternatives, and prefer direct verbs over nominalizations.
- Hyphenate compound adjectives before nouns when the phrase jointly modifies the noun, such as "long-term effects," "low-impact exercise program," and "middle-aged adults."
- Avoid ambiguous stacked noun compounds, especially in titles. Recast them with a prepositional phrase when needed to show the relationship, such as "AI counseling simulations with synthetic clients" instead of a front-loaded compound that could be parsed as a single system name.
- Define abbreviations at first use separately in the abstract, main text, and each figure/table legend when they appear there.
- Use natural scientific collocations. If a phrase sounds unnatural, replace it with a standard pairing, such as "arrived at the same conclusion."
- Prefer formal academic phrasing such as "jointly produce" over less formal or more ambiguous alternatives such as "co-produce" when describing multiple evidence sources or agents.
- Place modifiers close to what they modify. Avoid separating adverbs or phrases from their targets in ways that create ambiguity.
- Keep comparisons structurally balanced. Repeat the relevant preposition or use "that/those" with the preposition when comparing quantities across groups, such as "higher than that for sample B."
- Avoid contractions in academic prose. Use "do not," "cannot," and similar full forms.
- Reduce repeated nouns or articles in series when doing so preserves clarity.
- Distinguish the study from the paper, article, or manuscript. Use "study" for the research work conducted and "article," "paper," or "manuscript" for the written report.
- Use standard terminology in context: "personal information" in ethics and privacy literature and "80% power" for statistical power.
- Use "respectively" only when two or more parallel lists have the same number of elements and the mapping is unambiguous.
- In American English, use "that" for essential information and "which" for nonessential information.
- Keep validated field terminology even when a proofed edit sounds smoother. For example, do not change "sustain talk" to "sustainability talk" in motivational interviewing, or a population descriptor such as "middle-aged single men" into wording that changes marital or household meaning.

## Editing Priorities

Apply changes in this order:

1. Meaning and accuracy: preserve claims and avoid overstatement.
2. Sentence structure: fix ambiguity, misplaced modifiers, and unbalanced comparisons.
3. Academic tone: replace casual wording, contractions, and conversational phrasing.
4. Concision: remove redundancy and nominalizations.
5. Local mechanics: articles, hyphenation, abbreviations, punctuation, and table/figure definitions.

## Output Patterns

For a direct rewrite request:

```text
Polished version:
[edited academic English]

Notes:
- [brief explanation only for non-obvious changes]
```

For a manuscript-wide review:

```text
Priority issues:
- [issue type]: [example or location]

Suggested revision:
[revised passage]
```

For Japanese source text:

- Translate the intended meaning into natural academic English; do not mirror Japanese syntax.
- Ask only when the source leaves the scientific meaning genuinely ambiguous.
- Retain study-specific terms, variable names, and scale names unless a better English term is clearly established.

## Reference

For the detailed checklist derived from professional English-editing feedback, read `references/editor-feedback-checklist.md` when performing a careful revision, integrating a proofed manuscript file, or explaining why a sentence was changed.

---
name: academic-manuscript-english-writing
description: Draft, revise, self-proofread, and polish academic manuscript English for journal articles, abstracts, tables, figures, cover letters, and reviewer responses. Use when Codex needs to write or edit scholarly English for clarity, concision, formal tone, medical/scientific usage, abbreviation handling, balanced comparisons, article choice, compound modifiers, standard ethics/privacy or statistical terminology, collocations, genre-specific conventions, top-journal argument structure, contribution and gap framing, literature synthesis, claim calibration, section-to-section coherence, author-style calibration from prior writing samples, prose based on professional English-editing feedback, integration of proofed manuscript files, or extraction of reusable writing and self-editing rules from professionally edited DOCX tracked changes and comments while preserving scientific meaning and document structure.
---

# Write Academic English

## Checklist Policy

Use `references/editor-feedback-checklist.md` as the canonical detailed checklist for:

- drafting or substantially revising a title, abstract, manuscript section, table/figure legend, cover letter, or reviewer response;
- translating Japanese source text into any of those genres;
- integrating a professionally proofed manuscript file;
- performing a careful section-level or manuscript-wide self-proofread; and
- explaining substantive language edits.

For these tasks, read the checklist before writing or integration, apply it throughout the work, and complete its Final Pass before returning the output. Do not postpone its rules until a later proofreading stage.

For a short email or isolated sentence, apply the Manuscript Style Rules without loading the full checklist unless the user requests careful polishing or the text contains a scientifically sensitive claim whose meaning could be altered by editing.

## Reference Routing

- Read `references/genre-writing-guides.md` completely before drafting or substantially revising a title, abstract, manuscript section, table or figure legend, cover letter, or reviewer response. Apply only the sections relevant to the requested genre.
- Read `references/top-journal-argumentation-and-reporting.md` completely when the user asks to draft or substantially revise an Introduction, theory or literature-review section, Methods, Results, Discussion, or a full empirical manuscript for a selective journal; strengthen the research gap, contribution, argument architecture, literature synthesis, claim boundaries, reporting transparency, or reviewer readiness; or perform a manuscript-wide structural English review. Do not load it for isolated sentence-level polishing unless the sentence's claim strength depends on the study design.
- Read `references/author-style-calibration.md` completely when the user asks to match their established scholarly voice or supplies prior writing samples for style matching. Do not load it for ordinary drafting or polishing without a style-matching request.
- Read `references/professional-feedback-learning.md` completely when the user supplies professionally edited files to improve this skill, asks to extract reusable rules from tracked changes or comments, or asks for a self-proofreading process calibrated from prior professional feedback. Use `scripts/extract_docx_editor_feedback.py` for tracked-change DOCX files.
- When the top-journal and genre references both apply, first establish the source-supported research-question type, manuscript spine, claim ceiling, and section function; then apply the genre rules and language checklist. Derive an author-style profile last, and apply it only where it does not conflict with scientific meaning, journal requirements, disciplinary conventions, or consistency within the current manuscript.
- Keep detailed top-journal, genre, and calibration rules in their reference files rather than duplicating them in this file.

## Core Workflow

1. Identify the target genre and task depth: isolated polish, section-level revision, or manuscript-wide argument and language work.
2. Load the references required by the Checklist Policy and Reference Routing.
3. For section-level or manuscript-wide work, state internally the source-supported research question, gap, contribution, question type, and claim boundary. Mark missing inputs instead of inventing them.
4. Preserve the scientific meaning, study design, variables, units, statistics, and citation claims.
5. Draft or rewrite toward formal academic English: concise wording, direct verbs, precise collocations, balanced comparisons, clear modifier placement, and an explicit logical progression.
6. For multi-section work, verify that the title, abstract, Introduction, Methods, Results, and Discussion describe the same study design, primary question, analysis status, result direction, and claim strength.
7. Check local journal style if supplied. If current journal requirements or reporting-guideline versions must be established, verify them from official sources rather than relying on memory. If none is supplied, default to standard American academic English.
8. Before returning drafted text, complete the Final Pass required by the Checklist Policy and any routed reference. For an exempt short email or isolated sentence, run a targeted check for meaning, tone, grammar, and any relevant scientific terminology.
9. Provide the polished version first, then a short note on substantive changes or unresolved source gaps when useful.

## Boundary with Research Workflows

Use this skill as the default for English drafting, language-level revision, proofreading, genre-specific prose, author-voice calibration, and proofed-file integration. Keep research question development, literature retrieval, systematic review, citation existence verification, methodological redesign, simulated peer review, substantive reviewer-response strategy, and end-to-end research pipelines outside this skill.

This skill may diagnose a missing link in the manuscript's argument or reporting when that gap affects the requested prose. It must not silently choose a new estimand, analysis, hypothesis, theoretical position, reporting declaration, or evidentiary claim to fill that gap. Label the missing input and route the substantive decision to the user or an appropriate research workflow.

When `academic-research-suite` or an equivalent research workflow supplies an outline, evidence map, revision plan, citation audit, or response strategy, treat that artifact as content guidance. Apply the requested English drafting or polishing without silently extending, weakening, or contradicting it. Return to the research workflow for a new evidence check or substantive decision when a language edit would require changing the study claim, analysis, citation support, manuscript architecture, or response position.

## Integrating Proofed Manuscripts

When applying professional edits from a proofed file to an existing manuscript:

Follow the Checklist Policy before beginning the integration.

1. Treat the proofed file as proposed edits, not as automatically authoritative.
2. Identify the actual pre-proof source. If the working manuscript changed after proofreading began, use a three-way comparison among the pre-proof source, proofed file, and current manuscript so that later author revisions are not overwritten.
3. Inspect whether the proofed file contains tracked changes or comments. If it contains only clean final text, isolate the editor's changes by comparing it with the pre-proof source rather than with the current manuscript alone.
4. Compare the proofed version against the source at the title, heading, paragraph, table, figure, and reference levels before overwriting the source.
5. Apply wording, grammar, concision, punctuation, and formatting improvements only when they preserve the intended scientific claim.
6. Reject or repair proofed edits that change constructs, population descriptors, study design, modality, tense tied to study status, statistical meaning, measurement terminology, unit of analysis, or claim strength.
7. Treat smart quotes, escaped punctuation, line wrapping, generated media paths, table-layout changes, and missing back matter as possible format-conversion artifacts until the source comparison confirms that they are editorial changes.
8. Preserve source-only structural content such as table panels, figure links, local asset paths, raw Markdown/OpenXML blocks, supplement references, and complete reference lists unless the user explicitly asks to convert or remove them.
9. After integration, run a final integrity pass for headings, tables, figures, references, citations, DOI/URL coverage, statistics, abbreviations, and domain terms.

## Learning from Professional Feedback

When professionally edited manuscripts are supplied to improve this skill:

1. Follow `references/professional-feedback-learning.md` and extract DOCX evidence with `scripts/extract_docx_editor_feedback.py`.
2. Keep raw manuscript passages and comments in a temporary analysis artifact unless the user explicitly requests a retained corpus.
3. Group versions of the same manuscript before counting recurrence, and treat original editor comments as stronger evidence than machine translations or generic comments about flow.
4. Separate stable English rules from venue rules, domain terminology, author preferences, local repairs, substantive queries, and unsafe edits.
5. Add only stable, transferable language and self-check rules to the canonical checklist. Convert statistical or scientific concerns into verification triggers rather than automatic rewrites.
6. Test the extractor when its code changes and validate the whole skill after updating it.

## Manuscript Style Rules

- Prefer formal academic verbs and terms. Replace casual wording such as "give" with field-appropriate alternatives such as "administer" for dosage or interventions.
- Remove redundant initial articles from titles and headings when they add no meaning.
- Express ideas concisely. Replace wordy phrases with compact alternatives, prefer direct verbs or gerunds over nominalizations when grammatically natural, and keep coordinated alternatives structurally clear (for example, prefer "rather than relying on" to "rather than a reliance on" when the verbal construction fits the sentence).
- Hyphenate compound adjectives before nouns when the phrase jointly modifies the noun and the selected style calls for hyphenation, such as "long-term effects," "low-impact exercise program," and "middle-aged adults." Do not hyphenate established open or closed forms mechanically.
- Avoid ambiguous stacked noun compounds, especially in titles. Recast them with a prepositional phrase when needed to show the relationship, such as "AI counseling simulations with synthetic clients" instead of a front-loaded compound that could be parsed as a single system name.
- Define abbreviations at first use separately in the abstract, main text, and each figure/table legend when they appear there; after definition, use the selected abbreviation consistently within that component.
- Use natural scientific collocations. If a phrase sounds unnatural, replace it with a standard pairing, such as "arrived at the same conclusion."
- Prefer formal academic phrasing such as "jointly produce" over less formal or more ambiguous alternatives such as "co-produce" when describing multiple evidence sources or agents.
- Prefer a concrete subject and direct verb when an abstract subject obscures what actually acted, changed, measured, or was analyzed.
- Place modifiers close to what they modify. Avoid separating adverbs or phrases from their targets in ways that create ambiguity.
- Keep comparisons structurally balanced and compare like with like. Repeat the relevant preposition in paired alternatives (for example, "through X rather than through Y"), or use "that/those" with the appropriate preposition when the comparison otherwise pairs a property with an entity (for example, "higher than that for sample B").
- Keep correlative, negative, and causal alternatives parallel. Preserve repeated prepositions or subordinators when omitting them would blur scope, and prefer explicit frames such as "does not reflect X but rather Y" and "interpreted as X and not as Y."
- Match tense to rhetorical function: use past tense for completed procedures and observed results, present tense for general principles and what an article, table, or figure shows, and the appropriate planned or conditional tense for future work. Do not normalize tense across these functions mechanically.
- Preserve modal verbs, negation, hedging, and the object of a claim. Do not turn "may alter," "could indicate," or "would be needed for broader claims" into an unqualified assertion or a claim that the present findings require validation.
- Choose `must`, `should`, `need to`, `may/could`, and `can` according to the intended requirement, recommendation, necessity, possibility, or capability; never strengthen them mechanically for tone.
- Choose articles, number, and possession according to referential scope. Do not turn an aggregate construct into a single entity's possession, pluralize a study-specific system, or add "the" to a generic plural merely because the proofed sentence sounds smoother.
- Give pronouns and demonstratives an unambiguous antecedent, and keep coordinated lists parallel in both grammar and semantic role.
- Use commas between independent clauses joined by a coordinating conjunction and semicolons between closely related independent clauses without one. Do not use a comma alone to join two independent clauses, and retain the serial comma in lists when the selected style requires it.
- Avoid contractions in academic prose. Use "do not," "cannot," and similar full forms.
- Reduce repeated articles, head nouns, and shared modifiers in coordinated series when one occurrence can govern all items without changing scope or meaning (for example, "Layers 3 and 4" and "either the retained drafts or final responses"). Retain repetition when it distinguishes separate referents or prevents ambiguity.
- Standardize variant spellings and hyphenation throughout the manuscript (for example, choose either "nonrepetitive" or "non-repetitive" according to the journal or selected style and use it consistently). Do not mix forms merely because each is individually acceptable.
- Preserve established open-form constructs and official names. Do not hyphenate terms such as "change talk" or "sustain talk" as standalone nouns, and do not change an official name or reference title solely to enforce a manuscript-wide spelling preference.
- Distinguish the study from the paper, article, or manuscript. Use "study" for the research work conducted and "article," "paper," or "manuscript" for the written report.
- Use standard terminology in context: "personal information" for the intended general ethics/privacy construct unless a governing framework defines another term, and "80% power" for statistical power.
- Keep statistical notation internally consistent and journal-aligned. Do not insert or remove equals signs, abbreviations, decimal conventions, or label formatting in only one statistic without checking the surrounding abstract, text, tables, and legends.
- Check the noun and independence claim attached to every important number. Preserve distinctions among participants, sessions, scripts, ratings, observations, and other units of analysis.
- Use "respectively" only when two or more parallel lists have the same number of elements and the mapping is unambiguous.
- In American English, use "that" for essential information and "which" for nonessential information.
- Keep validated field terminology even when a proofed edit sounds smoother. For example, do not change "sustain talk" to "sustainability talk" in motivational interviewing, or a population descriptor such as "middle-aged single men" into wording that changes marital or household meaning.

## Drafting and Editing Priorities

Apply these priorities while drafting each passage and again during the checklist's Final Pass:

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

For a top-journal argument and language pass:

```text
Argument spine:
- Research question: [source-supported statement]
- Gap: [source-supported statement]
- Contribution: [source-supported statement]
- Claim boundary: [what the design and evidence permit]

Priority revisions:
- [section and issue]

Revised text:
[revised passage]

Unresolved source gaps:
- [input that must not be invented]
```

For Japanese source text:

- Apply the Checklist Policy according to the target genre; translation from Japanese is not an exemption from the pre-writing and Final Pass requirements.
- Translate the intended meaning into natural academic English; do not mirror Japanese syntax.
- Ask only when the source leaves the scientific meaning genuinely ambiguous.
- Retain study-specific terms, variable names, and scale names unless a better English term is clearly established.

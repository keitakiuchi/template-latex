# Claim Calibration and Rhetorical Risk

Use this reference for section-level or manuscript-wide work when sampling,
validation, generalizability, uncertainty, limitations, applicability, or future
research affects claim strength. Calibrate in both directions: prevent
overstatement without weakening conclusions below what the evidence supports.

## Contents

- Build a Claim Map
- Calibrate in Both Directions
- Limitation Propagation
- Specify Psychometric and Use Claims
- Control Global Verdict Language
- Distribute Qualifications Across Sections
- Run the EIC Quote Test
- Final Claim Pass

## Build a Claim Map

Map each major claim separately before drafting or substantially revising prose:

| Field | Question |
| --- | --- |
| Claim object | What exact result, measurement property, estimand, mechanism, or use is being discussed? |
| Direct evidence | Which supplied analysis or source supports it? |
| Status | Is it supported, mixed, unsupported, or not evaluated? |
| Population and context | In which source population, sample, setting, time frame, and mode was it evaluated? |
| Claim ceiling | What stronger interpretation is not supported? |
| Claim floor | What conclusion would understate the supplied evidence? |
| Limitation mechanism | How could a documented limitation bias, narrow, or destabilize this claim? |
| Propagation target | Which claims are actually constrained by that mechanism? |
| Unaffected claims | Which other results remain intact? |
| Permissible wording | What is the narrowest accurate positive conclusion plus any necessary qualification? |

Do not compress materially different claims into one global `Boundary`. Keep a
small map for ordinary empirical papers and expand it only when the study
evaluates several distinct properties, outcomes, estimands, or uses.

## Calibrate in Both Directions

- Enforce both the claim ceiling and the claim floor.
- Treat unsupported strengthening and unsupported weakening as meaning changes.
- State what the evidence establishes before stating what it does not establish.
- Use `mixed` only for a named claim with discordant or incomplete evidence.
- Do not convert evidence needed to extend a claim into doubt about a claim the
  present study directly supports.
- Do not repair strategic positioning by hiding material limitations or changing
  the study design, analysis, or intended use.

## Limitation Propagation

Propagate a limitation only when its mechanism can affect the claim being
qualified. Name the affected claim rather than attaching the limitation to
`the findings`, `the evidence`, or `validity` as a whole.

| Limitation | Usually constrains | Does not automatically negate |
| --- | --- | --- |
| Nonprobability sampling or low response | population prevalence, score distributions, reference values, and transportability across sampling frames | within-sample model fit, reliability, or associations |
| Follow-up attrition | longitudinal, change, survival, or repeated-measure estimates | baseline-only analyses |
| Measurement error | individual change interpretation and precision | group means, structural validity, or relative reliability |
| High factor correlation | distinctness of the affected factors or subscales | all evidence for a multidomain structure or a prespecified summary score |
| Self-reported comparators | claims about objective, clinical, or independently measured outcomes | all construct-validity evidence |
| Missing cutoff or criterion study | screening, classification, diagnosis, sensitivity, and specificity | descriptive or research use not requiring classification |
| Narrow setting or mode | transport to other settings or modes | results in the examined setting |

Treat these mappings as defaults to verify, not automatic statistical
conclusions. Selection can affect covariance structures, for example, when
selection relates to the variables or response processes under study.

## Specify Psychometric and Use Claims

Evaluate and describe content validity, structural validity, internal
consistency, reliability, measurement error, measurement invariance,
construct-validity hypothesis testing, criterion validity, and responsiveness
separately when the study distinguishes them. Evaluate each reported score or
subscale separately when its evidence differs.

Separate intended uses that require different evidence:

- describing group distributions;
- comparing groups;
- interpreting an individual's current score;
- detecting within-person change;
- screening or classification;
- diagnosis; and
- prediction.

Do not use `psychometric support`, `individual use`, or `generalizability` as a
single container when the source supports a more specific conclusion.

## Control Global Verdict Language

Treat `preliminary`, `promising`, `partial psychometric support`, `initial
validation`, `incomplete validation`, `evidence is weak`, and similar labels as
review triggers. Retain one only when it denotes a source-supported study stage
or a clearly named claim and is more informative than property-specific wording.

Prefer:

> Structural validity and internal consistency were supported in the examined
> sample, whereas evidence for individual change interpretation was limited by
> measurement error.

Avoid:

> The measure is preliminary but promising and has partial psychometric support.

Do not use `promising` as a substitute for a concrete result. Do not describe
validation as complete or incomplete when the informative distinction is which
properties and uses were evaluated.

## Distribute Qualifications Across Sections

- Put detailed mechanisms, sensitivity analyses, and future work in the
  Discussion or limitations section.
- In an abstract conclusion, lead with the strongest directly supported result
  and include only the qualification needed to prevent a likely misuse.
- In the final conclusion, state the supported use, the principal use boundary,
  and no more than the most consequential unresolved evidence.
- Avoid repeating the same global downgrade in the abstract, Discussion,
  limitations, conclusion, and cover letter merely for consistency.
- Align sections by claim object and evidentiary status, not by copying the same
  cautionary phrase into every section.

## Run the EIC Quote Test

Read the title, abstract conclusion, final limitations paragraph, final
conclusion, and cover letter as one short editorial packet. Then check:

1. Could one sentence be quoted alone as evidence that the whole study is
   unfinished when it actually limits only one claim or use?
2. Does a future-research sentence imply that present findings are invalid
   rather than that a broader application remains untested?
3. Does a sampling limitation distinguish target population, source population,
   sampling frame, analytic sample, and intended-use population?
4. Does the conclusion enumerate supported and unsupported claims instead of
   issuing a global maturity verdict?
5. Would removing repeated hedging preserve every material scientific boundary?

Use `scripts/audit_claim_language.py` as an advisory scan when plain-text or
Markdown manuscript text is available. Review every finding in context. Never
rewrite, suppress, or reject a manuscript mechanically from word counts alone.

## Final Claim Pass

- Every limitation has an explicit mechanism and a proportionate propagation
  target.
- Every major positive result appears at least once in the interpretation.
- No broad claim object converts a local limitation into global invalidity.
- No global verdict label replaces property-specific evidence.
- Title, abstract, Discussion, conclusion, and cover letter share the same claim
  map without accumulating redundant self-downgrading.
- Any change to the claim ceiling, claim floor, intended use, or population is
  verified with the user or the appropriate research workflow.

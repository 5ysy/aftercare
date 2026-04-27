# Tier Selection Rubric

Every aftercare skill lives in one of three tiers. Tier determines how many sub-files the skill should have. Pick the tier by counting which criteria the skill meets — **not** by taste.

See [`../../references/severity-model.md`](../../references/severity-model.md) for the global severity rubric that review skills apply to *findings*. This file is about the rubric for the *skill itself*.

## Lean tier — 0 sub-files

A lean skill is a short, single-purpose instruction. `SKILL.md` is everything.

Meets **all** of:

- Body stays ≤ 40 lines even when fully developed.
- Does not produce structured output (no report, no plan, no verdict).
- Does not classify findings by severity.
- Does not branch — there is one path through the skill.
- Does not teach a method that has named phases or stages.

Examples in this library: `using-aftercare` (a dispatch/index skill).

If you find yourself writing a second file for a lean skill, re-check the rubric. You may actually be in moderate tier.

## Moderate tier — 1–2 sub-files

A moderate skill has a concrete inspection method or a specific output format, but the scope is narrow enough that one or two supporting files cover it.

Meets **any two** of:

- Has an ordered inspection method (→ `checklist.md`).
- Classifies findings by severity or category (→ may use `rubric.md`).
- Has known common failure modes authors should name (→ `anti-patterns.md`).
- Produces a specific report/output shape different from the global template (→ `report-template.md`).
- Has a single branching decision that benefits from a diagram (→ `decision-tree.md`).

Examples in this library (after enrichment): `project-structure-review`, `dependency-governance`, `observability-review`, `test-hardening`, `executing-incremental-refactors`, `handling-review-feedback`.

Pick the one or two sub-files that address the criteria the skill actually meets. Do not add a sub-file for a criterion the skill does not meet.

## Heavy tier — 3+ sub-files

A heavy skill governs a multi-step review, produces structured output, teaches a method with named phases, and is worth supporting with examples.

Meets **any three** of:

- Is invoked as a primary review pass (architecture, boundary, pipeline, merge).
- Produces structured output a human will read and act on (report, plan, verdict).
- Has multiple inspection axes that each need their own checklist section.
- Needs before/after or good/bad examples for quality to be reproducible (→ `examples/`).
- Has a non-trivial decision tree (→ `decision-tree.md`).
- Carries severity deltas that differ from the global model (→ `rubric.md`).
- Is a meta-skill that governs the library itself (`writing-aftercare-skills`).

Examples in this library (after enrichment): `architecture-review`, `boundary-review`, `pipeline-review`, `refactor-planning`, `merge-readiness-review`, `writing-aftercare-skills`.

Heavy skills should almost always include `checklist.md` + `anti-patterns.md` + one of (`report-template.md` | `rubric.md` | `examples/`).

## Tier promotion — when and how

Promote only when the current tier's files can no longer absorb new content without violating the checklist (e.g., SKILL.md pushing past 80 lines, a single sub-file exceeding ~150 lines of mixed concerns).

Procedure:

1. Draft the new sub-files first, populated with real content carved out of the existing material.
2. Run [`checklist.md`](./checklist.md) against the new shape.
3. If the new files each have distinct, non-overlapping responsibility, commit the promotion.
4. If not, collapse back to the original tier — the skill was not ready.

## Tier demotion

If a skill has accumulated sub-files that do not pull their weight (thin, redundant, or orphaned), demote it. Deleting a sub-file is an improvement if it removes noise. This is especially common for skills that were originally authored in heavy tier by analogy.

## Quick check

Count the sub-files you plan to commit against the tier you picked:

| Planned sub-files | Tier must be |
| --- | --- |
| 0 | lean |
| 1–2 | moderate |
| 3+ | heavy |

If the count does not match the tier, stop and reconsider before committing.

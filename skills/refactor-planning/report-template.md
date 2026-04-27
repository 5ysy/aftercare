# Refactor Plan Template

Extends the refactor-plan format in [`../../references/report-templates.md`](../../references/report-templates.md) with explicit file lists, per-phase responsibilities, and stop points. Use this for every staged-repair plan.

```markdown
# Refactor Plan: [Short Name]

## Source findings
- [finding title, severity] — from [review report path or link]
- [finding title, severity] — from [...]

## Out of scope
- [finding or concern] — deferred because [reason]

## Goal
[One sentence. What improves without changing behavior.]

## Non-goals
- [behavior change, feature addition, style-only cleanup] — explicitly not this plan's work

## Behavior to preserve
- [external behavior 1] — currently pinned by [test path / test name, or "hardening phase 1"]
- [external behavior 2] — currently pinned by [...]

## Constraints
- Preserve external behavior (as listed above).
- Keep each phase independently verifiable and independently shippable.
- No phase mixes cleanup with behavior change.
- No phase exceeds [N] files or [M] lines of diff (set honest limits here).

## Phase 1 — [short name, e.g., "Harden invoice-generation contract tests"]
- **Responsibility:** [one sentence]
- **Files:** 
  - modify: `path/to/file1`
  - add: `path/to/new_file`
- **Verification:** 
  - [specific tests]
  - [manual checks]
- **Depends on:** none
- **Reviewable as:** a single PR

## Phase 2 — [short name]
- **Responsibility:** [...]
- **Files:** [...]
- **Verification:** [...]
- **Depends on:** Phase 1
- **Reviewable as:** a single PR

[... more phases, at most ~6 total ...]

## Stop points
The plan stops early — and ships what is complete — when any of:

- [condition 1, e.g., "tests fail unexpectedly in Phase 3 and reveal a hidden coupling not named in source findings"]
- [condition 2, e.g., "the team's confidence in the remaining phases drops below `continue`"]
- [condition 3, e.g., "gains from phases 5–6 become marginal after phases 1–4 land"]

For each stop point, the safe shipping state is: "phases 1 through N are merged; remaining phases become a separate follow-up plan."

## Gap to ideal
[If staged repair does not reach the ideal endpoint, name the remaining gap here so future reviewers recognize it as already-known.]

## Handoff
Execution is owned by [`../executing-incremental-refactors/SKILL.md`](../executing-incremental-refactors/SKILL.md). This document is the input to that skill.
```

## Notes

- Keep the plan legible by someone who did not write it. If a phase's "Responsibility" line needs internal vocabulary to make sense, add a one-line glossary.
- Files lists are load-bearing: they are the scope contract. "While I'm here" edits during execution violate the plan.
- Stop points are load-bearing: a plan without them is an invitation to push through when confidence has dropped.

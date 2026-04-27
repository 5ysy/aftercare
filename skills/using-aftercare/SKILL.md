---
name: using-aftercare
description: use when implementation already exists and the question has shifted from "can we build this?" to "did this damage the repo?". trigger after a feature merges, before calling work done, after a large ai-generated diff, or when reviewing someone else's completed change. do not use during feature construction — aftercare is for the phase after the code already works.
---

# Using Aftercare

Announce at the start: "I'm using using-aftercare to decide which post-development skills apply here."

## Core rule

Do not jump straight from "it works" to "it is done". Aftercare is the bridge between those two states.

## When to pick this skill

- Implementation passes tests but the diff still feels structurally wrong.
- An AI agent just landed a large change and you want to catch drift before it compounds.
- You are the reviewer on a PR and want a disciplined pass, not vibes.
- You are about to merge and want a defensible verdict.

## Default sequence

1. Scan the diff. Decide which **review skills** apply:
   - `architecture-review` — structural fit, misplaced responsibilities.
   - `boundary-review` — layering and dependency leaks.
   - `project-structure-review` — directory layout, discoverability.
   - `pipeline-review` — request, async, data, agent pipelines.
   - `dependency-governance` — new libraries, shared modules, coupling.
   - `observability-review` — logs, metrics, tracing, failure visibility.
   - `test-hardening` — tests protecting behavior before refactor.
2. Run the chosen reviews. Produce findings grouped by severity (see [`../../references/severity-model.md`](../../references/severity-model.md)).
3. If any finding is Medium or higher, run `refactor-planning` to convert findings into a staged plan.
4. If the plan is approved, run `executing-incremental-refactors` to execute it in small safe slices.
5. Before calling the work done, run `merge-readiness-review` and produce a verdict.

For the visual map of this flow, see [`../../references/workflow-maps.md`](../../references/workflow-maps.md) and [`../../docs/WORKFLOWS.md`](../../docs/WORKFLOWS.md).

## When to stop

- No medium-or-higher findings → skip straight to `merge-readiness-review`.
- Only cleanup-level findings → log them as backlog and merge.
- Findings are style preferences, not cost-or-risk issues → drop them; consult [`../../references/severity-model.md`](../../references/severity-model.md).

## When aftercare does not apply

- The code does not yet work. Go finish the feature first.
- You are exploring or prototyping. Premature review wastes cycles.
- The change is trivial (one-line fix, typo, doc tweak). Do not ceremonialize small work.

## Output style

Use the report templates in [`../../references/report-templates.md`](../../references/report-templates.md). Each review skill may extend the template with its own report shape; follow the skill's `report-template.md` when present.

## Full skill table

See [`../../README.md`](../../README.md#skill-library) or [`../../docs/SKILLS.md`](../../docs/SKILLS.md) for the complete library and one-line purposes.

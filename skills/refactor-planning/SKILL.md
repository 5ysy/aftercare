---
name: refactor-planning
description: turn aftercare review findings into a staged, low-risk refactor plan with explicit files, phases, and verification points. use after architecture-review, boundary-review, or pipeline-review finds medium-or-higher severity issues that need more than a single-slice fix — and before any code is written.
---

# Refactor Planning

Announce at the start: "I'm using refactor-planning to convert findings into a staged repair plan before any code moves."

## Core idea

A refactor plan is the contract that protects the repo from a reflex rewrite. It translates review findings into an explicit sequence of small, behavior-preserving, independently verifiable steps — with clear stop points and test hardening sequenced before any risky movement. The plan is a planning deliverable, not code.

## Workflow

1. Start from the findings. Read the review reports; identify which findings are in scope for this refactor and which are deferred.
2. Choose between staged repair and rewrite using [`decision-tree.md`](./decision-tree.md). Staged repair is the default; rewrite must clear a high bar.
3. Walk [`checklist.md`](./checklist.md) to convert findings into phases. Each phase is small, verifiable, and does one thing.
4. Sequence test-hardening before any phase that moves or reshapes behavior; link out to [`../test-hardening/SKILL.md`](../test-hardening/SKILL.md) rather than inlining those steps.
5. Write the plan using [`report-template.md`](./report-template.md), which extends [`../../references/report-templates.md`](../../references/report-templates.md) with explicit file lists, phase responsibilities, and stop points.
6. See [`examples/staged-plan.md`](./examples/staged-plan.md) for a complete worked plan.

## Rules

- **Preserve behavior.** External behavior (public API, response shape, side effects, performance envelope) does not change across the refactor.
- **Small steps.** Each phase is independently verifiable and independently shippable. If a phase must land with another to compile, it is too large.
- **Harden first, move second.** Never refactor on wishful confidence.
- **Separate cleanup from behavior changes.** If both are needed, they land in different changes.
- **Name stop points.** The plan states when to stop early (confidence dropped, gains diminishing, scope drifted).

## Heuristics

- Phases should match how the work would actually be reviewed — one phase per reviewable PR, roughly.
- A plan with more than ~6 phases is usually two plans poorly separated.
- If the plan reads "move everything, then fix up," it is a rewrite, not a staged repair.

## Do not

- include speculative cleanup "while we're in there"
- assume the plan will be executed in one session; write for handoff
- substitute a plan for a decision the author has not made yet (choose between alternatives before writing the plan)
- write a plan when the findings do not justify one — some findings are single-slice, and [`../executing-incremental-refactors/SKILL.md`](../executing-incremental-refactors/SKILL.md) can handle them directly

## Supporting files

- [`checklist.md`](./checklist.md) — converting findings into phases with the right granularity and sequence.
- [`decision-tree.md`](./decision-tree.md) — staged repair vs rewrite.
- [`report-template.md`](./report-template.md) — plan document format extending [`../../references/report-templates.md`](../../references/report-templates.md).
- [`examples/staged-plan.md`](./examples/staged-plan.md) — a complete worked plan.

## Output

Produce a plan using [`report-template.md`](./report-template.md). Hand the plan to [`../executing-incremental-refactors/SKILL.md`](../executing-incremental-refactors/SKILL.md) for execution; do not execute inside this skill.

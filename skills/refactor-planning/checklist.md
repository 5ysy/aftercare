# Refactor Planning Checklist

Use this to convert review findings into a staged plan. Run top-to-bottom; the order matters.

## 1. Scope the refactor

- [ ] Which findings is this plan going to address? List them by title and severity.
- [ ] Which findings are explicitly out of scope? Record them as deferred with a reason.
- [ ] Is the scope small enough that the plan has a believable endpoint (days/weeks, not quarters)?
- [ ] Has the author (human or agent) chosen between real alternatives, or is the plan a fence-sitter?

## 2. Decide repair mode

- [ ] Walk [`decision-tree.md`](./decision-tree.md). Record the verdict: staged repair or rewrite.
- [ ] If rewrite, stop. Either clear the rewrite bar (rare) or scope the work back down to staged repair.

## 3. Identify behavior to preserve

- [ ] List the external behaviors this refactor must not change (APIs, response shapes, side effects, performance envelope).
- [ ] For each, note how it is currently pinned by tests.
- [ ] For gaps, defer to [`../test-hardening/SKILL.md`](../test-hardening/SKILL.md) as the first phase(s).

## 4. Carve phases

- [ ] Each phase does **one** thing — one move, one extraction, one rename, one inversion.
- [ ] Each phase is independently verifiable (tests stay green or predictably-changed).
- [ ] Each phase is independently shippable (repo compiles, deploys, and works at the end of it).
- [ ] No phase mixes cleanup with behavior change.
- [ ] The plan has no more than ~6 phases; if it does, split into two plans with a stopping point between them.

## 5. Sequence phases

- [ ] Test-hardening phases come before the phases whose behaviors they protect.
- [ ] Foundational moves (introducing a new module, renaming a boundary) come before moves that depend on them.
- [ ] Risky phases (the ones most likely to surface hidden coupling) have test-hardening front-loaded.
- [ ] The phase order survives scrutiny: "if I stopped after phase N, is the repo still in a coherent state?"

## 6. Name files and responsibilities

- [ ] Each phase names the exact files it touches (create, modify, delete, move).
- [ ] Each phase states the responsibility that moves or changes — "extract invoice-generation orchestration into `services/invoice_service.py`", not "clean up the controller".
- [ ] Each phase has a verification step: tests to run, manual checks, specific assertions.

## 7. Stop points

- [ ] The plan lists the conditions under which to stop before the final phase (confidence drop, scope creep, gains diminishing).
- [ ] For each stop condition, the plan says what "done early" looks like — which phases are safe to ship on their own.
- [ ] The plan distinguishes "paused to revise" from "abandoned" and says what triggers which.

## 8. Handoff

- [ ] Is the plan readable by someone who did not write it?
- [ ] Does the plan say what to do on failure of each phase — revert, re-plan, or escalate?
- [ ] Has the plan been reviewed by a second pair of eyes before execution starts?

When every box is ticked, hand off to [`../executing-incremental-refactors/SKILL.md`](../executing-incremental-refactors/SKILL.md).

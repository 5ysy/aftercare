# Incremental Refactor Slice Checklist

Run before starting a slice, and again after completing it.

## Before the slice

- [ ] Is the goal of this specific slice one sentence, matching a phase in the plan?
- [ ] Do I know which tests will validate this slice?
- [ ] Is the working tree clean (no unrelated changes staged)?
- [ ] Is the test baseline green right now?
- [ ] Is the slice small enough to revert without regret?

## During the slice

- [ ] Am I only touching files the plan's current phase names?
- [ ] Am I resisting adjacent "while I'm here" edits? (Capture them as follow-ups instead.)
- [ ] If I am discovering that the slice is larger than planned, am I stopping to re-plan rather than expanding in place?

## After the slice

- [ ] Do the tests that were green before still pass?
- [ ] Is the external behavior (API shape, response format, side effects, performance envelope) unchanged?
- [ ] Is the change reviewable on its own — diff tells a coherent story without the rest of the plan?
- [ ] Is the slice committed (or checkpointed) before starting the next one?
- [ ] Is the running log updated: slice completed, any risk surfaced, any deferred follow-up?

## Red flags surfaced during a slice

- A test that was previously green now requires modification → suspect behavior change.
- A slice is producing a diff much larger than the plan implied → suspect scope creep.
- You find yourself writing "TODO" or "FIXME" in the new code → suspect unresolved design question; pause.
- Multiple slices must land together for the repo to compile → the plan's phasing is wrong; re-plan.

When any red flag fires, consult [`decision-tree.md`](./decision-tree.md) before continuing.

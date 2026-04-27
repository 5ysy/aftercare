# Slice Decision Tree

After each slice (or when a red flag fires mid-slice), walk this tree. Pick the first branch that matches honestly.

## 1. Did the slice's verification pass cleanly?

- **Yes, and scope stayed within plan** → **Continue** to the next slice.
- **Yes, but the diff exceeded what the plan implied** → **Pause**. Either split the completed slice in review, or update the plan before the next slice.
- **No, tests fail in a way consistent with the slice's intent** (e.g., the behavior was moved and the test was not yet updated) → follow the plan's rule for that case. If the plan did not anticipate it, **Pause** and re-plan.
- **No, tests fail unexpectedly** → go to 2.

## 2. Unexpected test failures

- **The failure points at genuine behavior change I did not intend** → **Revert the slice.** Re-plan; do not patch forward.
- **The failure points at a test that was too tightly coupled to the old structure** (identified during test-hardening as acceptable to move with the refactor) → update that test within this slice only; do not expand scope.
- **The failure is environmental or flaky** → reproduce in isolation first; do not assume flakiness.

## 3. Confidence check

After every 2–3 slices, stop and ask:

- Do I still understand what each remaining slice will do?
- Has any assumption from the plan been invalidated by what I have seen?
- Has the repo visibly improved so far, or am I churning?

- **Confidence high, improvement visible** → **Continue.**
- **Confidence has dropped** → **Pause.** Return to refactor-planning to revise the plan before proceeding.
- **Improvement has stalled** (slices are happening but the repo isn't measurably better) → **Stop.** Either the plan was wrong or the remaining gains don't justify the risk. Ship what works and close the refactor.

## 4. External interruption

If priorities shift or a production issue appears mid-refactor:

- **Are the completed slices individually safe to ship?** → yes, by construction. Ship them. Close out with the slices done so far; re-open the remainder as a new change later.
- **Is there a slice in progress?** → revert it unless it is trivially completable; do not leave the repo half-restructured.

## 5. Completion

Stop when:

- the plan's stated goal is met, **or**
- the repo is materially better and the remaining slices have diminishing returns, **or**
- confidence has dropped and re-planning would take longer than the remaining value.

Do not stop only because the plan "is finished" if the later slices are now clearly unnecessary.

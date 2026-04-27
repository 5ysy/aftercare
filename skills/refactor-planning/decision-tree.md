# Staged Repair vs Rewrite — Decision Tree

Rewrite is rarely the right answer. This tree makes you earn it.

## 1. Can each finding be addressed by moving, renaming, extracting, or inverting a named piece of code, without touching more than a few files per step?

- **Yes** → **Staged repair.** Proceed to [`checklist.md`](./checklist.md) phase 4.
- **No, but most findings can; a few are structural** → **Staged repair for the movable findings; defer or scope down the structural ones** into a separate change. Do not bundle.
- **No — the findings describe a shape that the current code cannot get to by local moves** → go to 2.

## 2. Is there at least one staged-repair path that improves the repo materially, even if it does not reach the ideal endpoint?

- **Yes** → **Staged repair.** The job of refactor-planning is to make the repo better, not to reach perfection. Plan for the improvement; accept that the endpoint is not the ideal one; document the remaining distance.
- **No — any partial progress leaves the repo worse than it is now** → go to 3.

## 3. Rewrite bar (all must be true)

- [ ] Two or more independent review reports (different authors or different skills) identify the same structural problem as unreachable by staged repair.
- [ ] The behavior to preserve is small enough to be re-implemented with confidence, or is covered by end-to-end tests that will pass unchanged against the rewrite.
- [ ] The team has the capacity to run the current code and the rewrite in parallel until cutover.
- [ ] There is a named rollback plan if the rewrite underperforms.
- [ ] A senior human has reviewed and approved the rewrite decision — this is not an agent-only call.

If any box is unchecked → **staged repair, scoped down.** If the staged repair cannot improve the repo at all, the finding is probably overstated or the scope is wrong; re-examine the review, not the code.

## 4. Anti-patterns in this decision

- **Rewrite reflex** — jumping to rewrite because the code "isn't clean." Covered by [`../../references/anti-patterns.md`](../../references/anti-patterns.md).
- **Infinite staging** — staged plan with 15 phases and no endpoint. Staged repair should be bounded; if it isn't, it is a rewrite wearing a plan as disguise.
- **Hybrid rewrite** — "we'll refactor as we go" during feature work. This is a rewrite with no scope, no stop point, and no testing discipline. Forbidden.

## 5. If the verdict is rewrite

- Do not write the rewrite plan in this skill. Rewrites are a different kind of project with different controls (parallel run, cutover, rollback).
- Write a short document stating: the findings, why staged repair failed the bar above, the named human approver, the expected scope. Hand off to the team's project-planning process.

## 6. If staged repair is chosen but the ideal endpoint is not reachable

- Proceed to [`checklist.md`](./checklist.md) phase 4 with the reachable endpoint.
- In the plan, note the gap between the refactor's endpoint and the ideal, so future reviewers do not re-flag it as a new finding.

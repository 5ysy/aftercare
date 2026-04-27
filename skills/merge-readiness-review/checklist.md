# Merge Readiness Checklist

Walk every section. Any unchecked Critical or High gate blocks "safe to merge".

## 1. Correctness gates (merge-blocking)

- [ ] All tests that should pass, pass. No red in CI.
- [ ] No known Critical finding is unresolved, or each is explicitly accepted as a named risk with written justification and owner.
- [ ] No behavior regression against documented contracts (APIs, response shapes, side effects).
- [ ] Any flaky tests involved in this area have been investigated, not silenced.

## 2. Boundary gates

- [ ] No unresolved boundary leak from [`../boundary-review/SKILL.md`](../boundary-review/SKILL.md) at High or Critical severity.
- [ ] If a new cross-feature import or shared-module bridge was introduced, it is either addressed or tracked as a named follow-up with an owner.
- [ ] Dependency direction matches the repo's implicit layering (no backflow without justification).

## 3. Pipeline gates

- [ ] For any retryable write path, idempotency is in place or the risk is explicitly accepted.
- [ ] No silent retry-exhaustion path on a critical flow.
- [ ] Stage boundaries are visible enough that an on-call engineer could locate a failure without reading the code.

## 4. Observability floor

- [ ] Failures on critical paths produce enough context to debug without attaching to production.
- [ ] At least one metric or health signal would surface a sustained problem within a reasonable window.
- [ ] Error paths are not catch-and-drop.

## 5. Deferred findings

- [ ] Every deferred finding has: an owner (person or team), a concrete trigger (next change in this area, next release, named issue), and a written reason.
- [ ] No finding is "deferred" as a synonym for "rejected without reasoning".
- [ ] The deferred list is visible in the PR description or linked tracker — not only in private notes.

## 6. Review feedback state

- [ ] Every comment from [`../handling-review-feedback/SKILL.md`](../handling-review-feedback/SKILL.md) has a recorded verdict (accept / defer / reject with reason).
- [ ] No Critical or High comment is silently unaddressed.
- [ ] The summary of accepts/defers/rejects is visible alongside the change.

## 7. Dependency hygiene

- [ ] Any new third-party dependency has an owner and a removal path.
- [ ] Any new internal shared module has more than one consumer, or is tracked to be demoted back to its owning feature if a second consumer does not appear.

## 8. Scope integrity

- [ ] The change is still coherent — no "while I was in there" edits that expand review surface.
- [ ] The change can be described in one or two sentences.
- [ ] Rollback is straightforward (single revert, no data migration to undo).

## 9. Verdict readiness

- [ ] Can I state, in one sentence, why this is the right verdict right now?
- [ ] Can I name the specific risk I am accepting by merging (if "merge with follow-up") or deferring (if "hold")?
- [ ] If I had to defend this verdict to the on-call engineer two weeks from now, would my reasoning hold?

If any of the last three answers is "no", the review is not done yet.

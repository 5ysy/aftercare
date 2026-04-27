# Merge Readiness Rubric

Extends [`../../references/severity-model.md`](../../references/severity-model.md). The rubric maps the current state of findings to one of three verdicts.

## Verdict: safe to merge

All of the following are true:

- No Critical finding is unresolved.
- No High finding is unresolved unless it has been explicitly accepted in writing with a named owner, trigger, and reasoning — and the risk is judged strictly lower than the cost of holding.
- Remaining Medium findings have owners and concrete triggers, or are explicitly closed as won't-fix with reasoning.
- Tests are green; no known flakiness in the affected area.
- The change is scope-coherent and rollback-friendly.

Use "safe to merge" when deferrals are **tracked, narrow, and honest**. Do not use it as shorthand for "I'm out of patience."

## Verdict: merge with follow-up

All "safe to merge" conditions hold, **plus**:

- At least one High or structurally meaningful Medium finding is being deferred.
- Each deferred finding has: an owner, a concrete trigger or deadline, a written reason, and a tracker entry (issue, ticket, recorded TODO).
- The cost of holding — blocking dependent work, stalling the change for re-review cycles, accumulating merge conflicts — is *judged* higher than the cost of the deferred finding shipping as-is.
- The deferred findings do not compound: if two deferred findings interact (e.g., a boundary leak *and* a missing test for that boundary), they do not land together as "merge with follow-up." Close one before merging.

Use this verdict when the change is a net improvement and the follow-ups are real work with real owners, not polite IOUs.

## Verdict: hold for refactor

Any one of the following:

- An unresolved Critical finding.
- An unresolved High finding that has no credible deferral path (no owner, no trigger, no written justification).
- Two or more interacting High findings — the compounding risk exceeds either one alone.
- A pipeline with retry-without-idempotency on a customer-impacting write path (from [`../pipeline-review/rubric.md`](../pipeline-review/rubric.md)) that is not fixed or explicitly and loudly accepted.
- Tests are not passing, or test confidence in the affected area is materially below the repo's baseline.
- The change is scope-incoherent (multiple unrelated concerns) — split before merging.

"Hold for refactor" is not a punishment. It is a signal that the cheapest path forward is to improve the change, not to merge and patch later.

## Risk accounting

For the verdict — whichever it is — name the risk in one sentence:

- **safe to merge** → "The remaining risk is [X], owned by [Y], and will be addressed by [trigger]."
- **merge with follow-up** → "By merging now, we accept [specific risk] in exchange for [specific cost of holding]. The follow-up is tracked at [link]."
- **hold for refactor** → "Holding now, because [specific unresolved risk] would compound if merged, and the cost of fixing before merge is [bounded estimate]."

## Anti-use

- Do not assign "merge with follow-up" for a change with zero deferred findings; that is "safe to merge".
- Do not assign "hold" because the change is unfamiliar or stylistically unusual; that is a style preference, not a risk.
- Do not invent severity to justify a predetermined verdict. Severity is set by earlier reviews, not by this one.

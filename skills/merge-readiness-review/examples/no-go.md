# Merge Readiness Example: NO-GO

A "hold for refactor" verdict on the fragile async-order pipeline from [`../pipeline-review/examples/fragile-pipeline.md`](../../pipeline-review/examples/fragile-pipeline.md).

---

# Merge Readiness: Async order processing (handle_order_message)

## Change
- **PR / branch:** #503, branch `feature/async-order-handler`
- **Summary:** Introduces an async job that charges the card, creates a shipment, notifies the customer, and acks the queue message.
- **Scope coherence:** single concern (the async order handler). But see Unresolved below.

## Inputs
- **Prior reviews:** `pipeline-review/examples/fragile-pipeline.md` — Critical ×1, High ×2, Medium ×1.
- **Test state:** happy-path tests green. No test covers retry semantics. No test covers duplicate delivery.
- **Handled feedback:** reviewer asked about idempotency; the author replied "the queue rarely retries, should be fine." No written verdict, no tracker entry.

## Finding state

### Resolved
- None.

### Deferred (tracked)
- None.

### Unresolved
- **Retry without idempotency on payment (Critical)** — status: unaddressed. Author acknowledges the concern verbally; no code change, no tracker, no explicit risk acceptance.
- **Duplicate shipments on retry (High)** — status: unaddressed. Same as above.
- **Silent retry exhaustion / no DLQ alert (High)** — status: unaddressed. Author points at the generic error-rate dashboard as "good enough"; no metric specific to this job type.
- **Implicit stages (Medium)** — status: acknowledged; the author plans to split into named stages "in a follow-up."

## Verdict
**hold for refactor**

## Risk accounting
Merging now would accept a Critical finding (duplicate charges on retry) with no mitigation, no written acceptance, and no named owner of the follow-up. The cost of fixing before merge is bounded — an idempotency key on the payment call is ~3 lines; the shipment dedupe is a small conditional in the warehouse call; the DLQ metric is a one-line addition. Holding is the cheaper path.

## Why this verdict, not another
- **Not `safe to merge`** because an unresolved Critical finding exists.
- **Not `merge with follow-up`** because:
  1. None of the unresolved findings have an owner, a trigger, or a tracker entry — "I'll look at it later" is not a deferral.
  2. The Critical + High findings interact: if the Critical is patched but the shipment dedupe is deferred, retries still double-ship. The combined risk exceeds either alone.
  3. The author's reply ("should be fine") indicates the risk has not been internalized, which is a separate concern the merge verdict should not paper over.

This would flip to `merge with follow-up` only if the Critical were closed (idempotency key added and tested) **and** the two High findings were tracked with named owners and concrete triggers. Even then, the shipment dedupe is a small enough change that closing it in the same PR is preferable.

## Action
Do not merge. Before re-requesting merge readiness review, the author should:

1. Add an idempotency key to the payment call and a test that simulates duplicate delivery.
2. Add a shipment dedupe and a test for it, **or** track it as a follow-up with owner and trigger.
3. Add a metric and alert specifically for DLQ arrivals on this job type, **or** track it as a follow-up with owner and trigger.
4. Process the reviewer's idempotency comment per [`../handling-review-feedback/SKILL.md`](../../handling-review-feedback/SKILL.md) — accept, defer, or reject, in writing.

Re-review when steps 1 and 4 are done and at least one of 2 or 3 is either fixed or tracked.

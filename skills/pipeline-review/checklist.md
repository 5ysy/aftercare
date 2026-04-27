# Pipeline Review Checklist

Identify the pipeline type first, then walk the relevant section. Cross-cutting sections (retry, idempotency, operator visibility) apply to all types.

## 1. Stage inventory (all types)

- [ ] Can I list the stages by name, from the code, in order?
- [ ] Does each stage have explicit inputs and outputs, or are they reconstructed from call order?
- [ ] Is there a single place that describes the pipeline as a whole, or must a reader stitch it together?

## 2. Request flow pipelines

- [ ] Is the request/response boundary clear, with orchestration separate from transport?
- [ ] If a downstream call fails mid-request, is the client's view of the failure coherent (not a generic 500 with no context)?
- [ ] If the request has side effects, are partial-success states recognized and either completed or rolled back?

## 3. Async job pipelines

- [ ] Is enqueue separate from execute (a job id, visible state, retrievable result)?
- [ ] Does the job have a name, a version, and a payload schema?
- [ ] Are long-running jobs checkpointed, or do retries restart from scratch?
- [ ] Is there a dead-letter path for jobs that exhaust retries?

## 4. Data pipelines

- [ ] Are stages of the data flow (extract, transform, load, or their equivalents) clearly separated?
- [ ] Does each stage produce an artifact (file, table, topic) that downstream stages read, or is data passed in memory across stage boundaries?
- [ ] Is there a way to re-run a single stage without re-running upstream ones?
- [ ] If a stage re-runs on the same input, is the output guaranteed to be the same (determinism) or logically equivalent?

## 5. Agent workflows

- [ ] Are tool invocations, model calls, and state transitions distinct stages with logged boundaries?
- [ ] Is there a maximum step count or cost ceiling, enforced explicitly?
- [ ] Is the agent's state persisted between steps, so a crashed run can resume or be inspected?
- [ ] Is there a path for a human to intervene without killing the run?

## 6. Retry behavior (all types)

- [ ] Does each retryable stage have a retry policy (count, backoff, jitter)?
- [ ] Is the policy expressed once in a named place, or scattered?
- [ ] Does a retry distinguish transient errors from permanent ones, or does it retry everything?
- [ ] On retry exhaustion, does control pass somewhere — dead-letter, alert, error state — or does the work silently disappear?

## 7. Idempotency (all types)

- [ ] Is each retryable stage idempotent (same input → same observable effect)?
- [ ] If the stage writes to storage, is there an idempotency key, conditional write, or upsert — or does retry produce duplicates?
- [ ] If the stage calls an external system, is the external system idempotent for this operation, or is there a local dedupe layer?
- [ ] If the stage emits events, is emission deduplicated on retry?

## 8. Manual re-run

- [ ] Can an operator re-run a specific stage on a specific input from a runbook-like command?
- [ ] Will re-running produce duplicate side effects?
- [ ] Is there a way to mark a job "completed by operator" so the scheduler stops retrying?

## 9. Observability (summary; defer details to observability-review)

- [ ] Are stage boundaries logged on entry and exit with correlation identifiers?
- [ ] Is there a metric that fires specifically on retry exhaustion, not just general error rate?
- [ ] Can an operator answer "where in the pipeline is job X right now?" from artifacts alone?

Pure observability findings belong to [`../observability-review/SKILL.md`](../observability-review/SKILL.md). Findings about *stage semantics*, *retry correctness*, or *idempotency* belong here, even if they also have an observability angle.

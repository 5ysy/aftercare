# Pipeline Review Anti-Patterns

Start from [`../../references/anti-patterns.md`](../../references/anti-patterns.md). Below are pipeline-specific shapes.

## Invisible stages

The pipeline works but has no named stages. Code reads as one long function or as a call chain whose boundaries only the author remembers. Operators cannot say "stage 3 failed" because there is no stage 3. Refines [`../../references/anti-patterns.md`](../../references/anti-patterns.md) "Invisible orchestration".

## Retry-without-idempotency

A stage retries on failure but writes to external systems without dedupe. Happy path works; retries double-charge, double-send, or double-record. The code is "correct" under the assumption of no retries.

## Retry everything

Retries trigger on every exception, including validation errors and permanent auth failures. The pipeline loops forever on inputs that will never succeed, filling logs and possibly costing money.

## Silent giving up

Retry exhaustion drops the work with no signal — no dead-letter, no alert, no failure metric. Operators discover the problem when downstream data is missing, usually days later.

## Cross-stage in-memory state

State flows across stage boundaries via in-memory references instead of durable artifacts. Crashing between stages loses the partial progress; re-running from the start is the only recovery.

## Orchestration in the adapter

The orchestration lives inside an infrastructure adapter (queue consumer, HTTP handler, cron function) instead of a dedicated orchestration module. Changing transport rewrites the pipeline.

## Rerun ambiguity

Re-running a stage manually has different semantics from the scheduler re-running it (different inputs, different side-effect scope, different logging). Operators do not know which mode they are in.

## Fan-out without fan-in

A stage triggers N child operations in parallel, but there is no join — no aggregation, no completion signal. Downstream consumers cannot tell when the set is done.

## Unbounded agent loop

An agent workflow retries tool calls, re-plans, or self-corrects with no explicit step or cost ceiling. The run either succeeds quickly or burns through budget unnoticed.

## Idempotency-by-comment

A docstring says "this is idempotent" but the code contains no idempotency key, conditional write, or dedupe. Future changes will break the invisible assumption.

## Retry storm

On systemic failure (downstream outage), retries across many jobs hit the failing system in a tight loop. No jitter, no circuit breaker, no backoff ceiling. The pipeline amplifies the outage instead of absorbing it.

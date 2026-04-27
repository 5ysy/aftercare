# Pipeline Review Severity Rubric

Extends [`../../references/severity-model.md`](../../references/severity-model.md) with pipeline-specific deltas. Use these alongside the base model — when they disagree, the stricter applies.

## Promotion rules (make severity stricter)

Promote a finding one level (Medium → High, High → Critical) when any of these apply to a retryable or operator-facing stage:

- **Retry without idempotency on a write path.** Duplicate side effects in production are a correctness failure, not a maintainability concern.
- **Silent retry exhaustion on a critical path.** Work disappearing without signal is a Critical candidate regardless of how clean the code looks.
- **Cross-stage state held only in memory on a long-running pipeline.** A crash loses committed work.
- **Unbounded agent loop or retry storm** (no step/cost ceiling, no backoff ceiling). Cost and blast-radius risk.

## Demotion rules (make severity lighter)

Demote a finding one level when:

- The stage is **not on a critical path** (internal reporting, non-user-facing tooling, test fixtures).
- The pipeline is **explicitly single-run and non-retryable** (e.g., a one-shot migration script), and the finding is about retry semantics that do not apply.
- The concern is **pure observability** with no stage-semantics or correctness impact — hand it to [`../observability-review/SKILL.md`](../observability-review/SKILL.md) at that skill's severity bar.

## Pipeline-type floor

Regardless of the base severity model, a finding cannot be below the floor for its type:

| Pipeline type | Retry/idempotency gap floor | Silent failure floor | Stage ambiguity floor |
|---|---|---|---|
| Request flow (user-facing) | High | High | Medium |
| Async job (customer-impacting) | High | Critical | Medium |
| Data pipeline (produces durable artifacts) | High | High | Medium |
| Agent workflow (budget-bounded, external calls) | High | High | Medium |
| Internal tooling (non-critical) | Medium | Medium | Low |

## Verdict language

In the report, prefer:

- **Critical** → "merge should stop until this is fixed or explicitly accepted"
- **High** → "fix before merge or plan a named follow-up landing within this sprint"
- **Medium** → "track in the backlog with owner; not a merge blocker"
- **Low** → "improvement suggestion; no action required"

## Anti-use

Do not inflate severity because a pipeline "feels risky." Inflation is as costly as understatement — it makes every review loud, and real Critical findings get lost. Ground each promotion in a specific rule above.

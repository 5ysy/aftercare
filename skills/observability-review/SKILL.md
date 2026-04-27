---
name: observability-review
description: review completed changes for logging, metrics, tracing, error context, and operator visibility. use when work touches async jobs, pipelines, retries, external integrations, background workers, or any failure-prone code path where a future on-call engineer will need to answer "what happened" from artifacts alone.
---

# Observability Review

Announce at the start: "I'm using observability-review to check whether a future on-call engineer could debug this without guessing."

## Core idea

Assume future engineers will debug this under pressure, at 3 a.m., without the author present. Every critical transition, failure, and retry should leave a readable trail. Observability is not about log volume — it is about whether the system can explain itself.

## Workflow

1. Identify the risky surfaces in the change: async boundaries, external calls, retry loops, state transitions, error paths.
2. For each risky surface, run [`checklist.md`](./checklist.md) to determine whether logs, metrics, tracing, and error context are adequate.
3. For each gap, imagine a specific on-call scenario: "The job fails silently — what would the operator see?" If the answer is "nothing useful," it is a finding.
4. Classify findings using [`../../references/severity-model.md`](../../references/severity-model.md). A silent failure on a critical path is High or Critical; a missing debug log on a non-critical path is Low.

## Heuristics

Recommend improvements when:

- a failure would leave no trace beyond "something broke"
- retries happen but no signal distinguishes "flaky network" from "persistent failure"
- metrics exist but operators cannot tell healthy from unhealthy from them
- errors are caught and logged as strings, losing stack, context, or correlation IDs

## Do not

- demand structured logging, tracing, and metrics on code paths that do not need them
- flag log-level choices as if they were correctness issues
- ask for observability that the surrounding system does not support

## Supporting files

- [`checklist.md`](./checklist.md) — per-surface inspection steps for logs, metrics, tracing, error context, and health signals.
- [`report-template.md`](./report-template.md) — observability-finding report format extending [`../../references/report-templates.md`](../../references/report-templates.md).

## Output

Use [`report-template.md`](./report-template.md). Tie every finding to a concrete debugging scenario or operational ambiguity, not to a general "best practice."

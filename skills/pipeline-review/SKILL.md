---
name: pipeline-review
description: inspect completed request flows, async jobs, data pipelines, and agent workflows for stage ambiguity, failure-handling gaps, retry and idempotency mistakes, and poor operator visibility. use after pipeline-related work, before shipping orchestrated flows, or when the change introduces any multi-stage process where partial failure matters.
---

# Pipeline Review

Announce at the start: "I'm using pipeline-review to treat this flow as an operational system, not just code."

## Core idea

A pipeline is not just a sequence of function calls. It is an operational system with stages, failure modes, retry semantics, and an operator surface. Review it as such: ask where stages begin and end, what happens when each one fails, what is re-run vs re-executed, what a human can see and do mid-flow.

## Workflow

1. Identify the pipeline type — request flow, async job, data pipeline, agent workflow — because the important questions differ. See [`checklist.md`](./checklist.md), which has a section per type.
2. List the stages explicitly. If you cannot, the first finding is that stage boundaries are not visible.
3. For each stage, walk the relevant [`checklist.md`](./checklist.md) section covering inputs/outputs, failure mode, retry behavior, idempotency, and observability.
4. Check findings against [`anti-patterns.md`](./anti-patterns.md).
5. Set severity using [`rubric.md`](./rubric.md), which refines [`../../references/severity-model.md`](../../references/severity-model.md) for pipeline-specific deltas — retry and idempotency bugs are often Critical even when the code "works" in the happy path.
6. See [`examples/fragile-pipeline.md`](./examples/fragile-pipeline.md) for a worked case.

## The three questions

For any pipeline, answer these before writing findings:

- **If this fails in production, how will someone know where?**
- **If this retries, what duplicate or corruption paths exist?**
- **If a stage is re-run manually, what happens?**

A pipeline that cannot answer all three clearly has at least one High finding regardless of how clean the code looks.

## Heuristics

- Named stages beat implicit call sequences. If the stages have no names, operators cannot talk about them.
- Idempotency is a property of a stage, not an aspiration of the pipeline. Review per stage.
- Every retry is a duplicate-execution risk; every duplicate execution is a correctness question.

## Do not

- flag every sync function as needing to be async
- demand distributed-systems machinery on pipelines that are not distributed
- critique the choice of orchestrator when the concern is actually stage semantics

## Supporting files

- [`checklist.md`](./checklist.md) — per-pipeline-type inspection steps (request / async / data / agent).
- [`anti-patterns.md`](./anti-patterns.md) — pipeline-specific anti-patterns extending [`../../references/anti-patterns.md`](../../references/anti-patterns.md).
- [`rubric.md`](./rubric.md) — pipeline-specific severity refinements.
- [`examples/fragile-pipeline.md`](./examples/fragile-pipeline.md) — worked case of a pipeline with silent retry duplication.

## Output

Use the review-report format in [`../../references/report-templates.md`](../../references/report-templates.md). Cross-reference [`../observability-review/SKILL.md`](../observability-review/SKILL.md) for pure visibility findings; this skill owns the stage / retry / idempotency side.

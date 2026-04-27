# Business Scenarios

## Early-stage product
Prioritize speed and clarity.
Recommend small structure improvements, not heavy architecture frameworks.

## Mature backend service
Be stricter about boundaries, observability, contracts, and merge gating.

## Data and async pipelines
Be strict about stage contracts, retries, idempotency, backfills, and operator visibility.

## Agentic application
Be strict about prompt orchestration boundaries, state ownership, tool wrappers, and logging of agent decisions.

## Monorepo
Review should pay extra attention to dependency direction, package ownership, shared abstractions, and accidental cross-package imports.

## Internal tools
Do not over-engineer, but still defend discoverability and change safety.

# Boundary Review Anti-Patterns

Start from [`../../references/anti-patterns.md`](../../references/anti-patterns.md). The patterns below are boundary-specific.

## Dependency backflow

A lower-level module imports from a higher-level one — domain imports controller, core imports adapter, shared imports feature. Direct refinement of [`../../references/anti-patterns.md`](../../references/anti-patterns.md) "Dependency backflow".

## Reach-through import

A consumer imports from a package's internal files (`pkg._internal.thing`, `pkg/sub/helper.py`) instead of its public surface. The consumer is now coupled to the provider's internals; refactoring the provider will silently break the consumer.

## Cross-feature familiarity

Feature A directly imports types, functions, or modules from feature B's internals. Features that are supposed to be independent are now transitively coupled. A change to either one forces review of both.

## Shared-module bridge

A `shared/` or `common/` module knows about feature-specific types. Feature A writes, feature B reads, and the "shared" module is really a private API between them wearing a generic label. Refines [`../../references/anti-patterns.md`](../../references/anti-patterns.md) "Shared-utils sinkhole" at the coupling level.

## Policy in the adapter

Authorization, validation, or business rules live inside an infrastructure adapter (repository, HTTP client, queue consumer). The policy moves with the transport and is invisible to domain tests. Refines [`../../references/anti-patterns.md`](../../references/anti-patterns.md) "Controller-as-service" for the adapter case.

## Transport type in domain

A framework-specific type (HTTP request/response, ORM model, queue message) is referenced inside a domain module. The domain can no longer be reasoned about or tested without the framework.

## Implicit boundary

A boundary exists in the team's mental model but not in the code — no module boundary, no import restriction, no interface. Violations are invisible because the boundary is invisible. The review should flag this as a structural ambiguity, not just file-by-file leaks.

## Convenience global

A module-level singleton, global registry, or ambient context is used to pass data across a boundary without an explicit import graph edge. The coupling is real but does not show up in static analysis.

## Tests crossing boundaries

Tests for feature A import and set up feature B's internals. Any legitimate refactor of B breaks A's tests. This often *reveals* an earlier production-code leak; trace it back.

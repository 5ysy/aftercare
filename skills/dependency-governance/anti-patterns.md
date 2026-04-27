# Dependency Governance Anti-Patterns

Start from [`../../references/anti-patterns.md`](../../references/anti-patterns.md). The patterns below are the dependency-specific deltas and refinements.

## Reflexive wrapper

A thin wrapper is added around an external library "in case we want to swap it later." The swap never happens; the wrapper just renames the API and blocks access to library features.

## Speculative shared module

A module is created in `shared/` or `common/` with a single consumer and a comment that says "other features will use this soon." They won't.

## Utility attractor

A folder named `utils/`, `helpers/`, or `common/` grows monotonically because it is the path of least resistance for anything that doesn't obviously belong elsewhere. Refines [`../../references/anti-patterns.md`](../../references/anti-patterns.md) "Shared-utils sinkhole".

## One-feature generic

An abstraction is designed to support N features but currently serves one. The generality is a cost paid immediately for a benefit that may never arrive.

## Dependency backflow

A lower-level module imports a higher-level one — domain imports controller, core imports adapter, shared imports feature. Refines [`../../references/anti-patterns.md`](../../references/anti-patterns.md) "Dependency backflow".

## Silent footprint

A "small" new package pulls a large transitive tree, adds meaningful install/build time, or introduces a native-code dependency that was not discussed.

## Version drift

A new dependency is pinned to a version that conflicts with or duplicates an existing dependency's transitive pin, creating two copies of the same library in the tree.

## Orphan dependency

A dependency is added with no named owner. When it breaks or needs upgrade, no one is responsible. Treat as High severity if it sits on a critical path.

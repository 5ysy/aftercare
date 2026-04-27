# Architecture Review Anti-Patterns

Start from [`../../references/anti-patterns.md`](../../references/anti-patterns.md). The patterns below are architecture-specific refinements and additions.

## Decision-in-the-wrong-layer

The code that decides lives in the code that transports. Controllers contain business rules; adapters carry policy; routes own authorization logic. Refines [`../../references/anti-patterns.md`](../../references/anti-patterns.md) "Controller-as-service".

## Anemic domain

Domain modules exist but contain only data structures; all real decisions happen in orchestration or adapters. The "domain" layer is decorative.

## Ghost orchestration

There is no named orchestration layer; multi-step flows are reconstructed by reading call stacks. Refines [`../../references/anti-patterns.md`](../../references/anti-patterns.md) "Invisible orchestration" as the structural (rather than observability) angle.

## Framework-shaped domain

Domain modules are shaped by framework conventions (ORM models, controller signatures, DI containers) rather than by the business vocabulary. The domain cannot be tested or reasoned about without the framework loaded.

## Layering theater

The repo has `domain/`, `application/`, `infrastructure/` folders, but imports cross freely in all directions. The folders are labels, not boundaries.

## Hidden god module

A single module — often named innocuously (`core.py`, `manager.ts`, `service/index.go`) — accumulates responsibilities from multiple features. Imports into it are wide; imports out of it reach into every layer.

## Coupling via shared types

Two features that should be independent share a "common types" module so large that any change to one feature forces recompilation or review of the other. The coupling is hidden in the type graph.

## Premature layering

A small change introduces three new abstraction layers for future flexibility that no one has asked for. Refines [`../../references/anti-patterns.md`](../../references/anti-patterns.md) "Premature platforming" at the architectural scale.

## Test-shape lock-in

Tests bind so tightly to the current structure that the structure cannot be fixed without rewriting the tests. The tests have become the argument for keeping the wrong shape.

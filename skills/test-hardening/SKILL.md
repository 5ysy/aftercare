---
name: test-hardening
description: strengthen tests around existing behavior before or during a structural refactor. use when architecture-review or refactor-planning identifies worthwhile changes but current tests do not adequately protect the behavior the refactor would move, rename, or reshape.
---

# Test Hardening

Announce at the start: "I'm using test-hardening to decide what behavior must be protected before the refactor moves."

## Core idea

Do not refactor on wishful confidence. A refactor is safe only to the extent that the existing behavior is pinned down by tests that will notice if it changes. Hardening is a short, focused pass that adds the minimum tests needed to make the planned refactor safe — not a general test-coverage push.

## Workflow

1. Read the approved refactor plan (or the findings that will lead to one). Identify the specific behaviors the refactor will move, rename, split, or merge.
2. For each such behavior, run [`checklist.md`](./checklist.md) to decide whether current tests adequately pin it down.
3. For gaps, write the smallest test that would fail if the behavior changed — prefer end-to-end or contract tests over deeply coupled unit tests that will themselves need rewriting.
4. Check findings against [`anti-patterns.md`](./anti-patterns.md) to avoid the common hardening mistakes.
5. Stop when the refactor's risky movements are protected. Do not keep going into unrelated coverage.

## Heuristics

Prefer:

- tests at the boundary the refactor will preserve, not the boundary it will change
- one good end-to-end or contract test over five brittle unit tests
- tests that describe behavior in the domain vocabulary, not the current implementation vocabulary

## Do not

- rewrite the test suite under the banner of "hardening"
- add tests tightly coupled to the code that is about to move (they will be deleted immediately)
- use test-hardening as an excuse to skip or indefinitely defer the refactor

## Supporting files

- [`checklist.md`](./checklist.md) — per-behavior inspection for regression, contract, and branch coverage.
- [`anti-patterns.md`](./anti-patterns.md) — hardening-specific anti-patterns extending [`../../references/anti-patterns.md`](../../references/anti-patterns.md).

## Output

State which behaviors need protection before the refactor and why, then recommend the smallest useful set of tests with their type (unit / contract / end-to-end) and where they belong.

# Test Hardening Anti-Patterns

Start from [`../../references/anti-patterns.md`](../../references/anti-patterns.md) — "Test illusion" is the root pattern. The deltas below apply specifically to pre-refactor hardening.

## Hardening the wrong layer

Tests are added against the code that is about to be moved or rewritten. They will be deleted or heavily edited during the refactor and provide no real safety net. Prefer tests at the preserved boundary.

## Snapshot hardening

A snapshot test is added that captures current output verbatim, including incidental formatting. The snapshot passes before the refactor and fails after for reasons unrelated to behavior, training the team to regenerate snapshots reflexively.

## Coverage-percentage hardening

Tests are added to raise a coverage number rather than to protect specific behaviors identified in the refactor plan. The tests exercise lines without asserting meaningful outcomes.

## Mock-heavy hardening

New tests stub so much of the surrounding world that they assert the mocks' behavior, not the code's. After the refactor the mocks still pass even if the real behavior has broken.

## Hardening as refactor-avoidance

Hardening expands indefinitely. Every week produces more tests and no structural change. The refactor is quietly buried. Refines [`../../references/anti-patterns.md`](../../references/anti-patterns.md) "Test illusion" by naming the procrastination mode.

## Hardening unrelated code

The hardening pass grows to cover behaviors the refactor will not touch. Useful in isolation, but out of scope; it delays the refactor and inflates the change set.

## Brittle branch pinning

A test is written that pins an internal branch (e.g., "the second `if` evaluates to false") rather than the observable behavior. The refactor legitimately restructures the branches and the test fails for no real reason.

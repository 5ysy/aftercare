# Review-Handling Anti-Patterns

Start from [`../../references/anti-patterns.md`](../../references/anti-patterns.md). The patterns below are specific to how feedback gets mishandled.

## Performative agreement

Every comment is accepted without verification. The diff grows with small changes that were never validated as correct, and the author gains a reputation for being "responsive" while the code drifts.

## Blind implementation

An AI-generated comment is implemented verbatim, including any misreading the agent made. The "fix" introduces a new bug the reviewer would have caught if the author had verified the claim first.

## Reflexive defense

Every comment is rejected because "the tests pass." Tests prove the presence of tested behavior, not the absence of structural problems. Structure comments are dismissed on correctness grounds.

## Silent unresolved

A Critical or High comment is neither addressed nor explicitly accepted as a known risk. The PR merges; the comment is forgotten. Treat unresolved structural blockers as merge-blocking unless written down.

## Agreement-then-scope-creep

A small comment is accepted and then used as justification for a large unrelated refactor in the same change. The reviewer's small concern becomes cover for a rewrite they did not ask for.

## Classification avoidance

Every comment is handled as "preference" to keep the change small, or as "correctness" to stall the change indefinitely. The classification is load-bearing — skipping it removes the only signal for how seriously to take the comment.

## Batch rejection

Several related comments are dismissed with a single "I disagree" and no per-comment reasoning. Each comment is a separate claim and needs a separate verdict, even if the reasoning rhymes.

## Weight inversion

Human reviewer comments are dismissed as "opinion" while agent comments are treated as authoritative (or vice versa). Source affects how much *context* you credit, not whether verification is required.

## Defer-as-reject

"Deferred" with no trigger, no owner, no tracked follow-up. This is rejection dressed politely. Either track it concretely or reject it honestly.

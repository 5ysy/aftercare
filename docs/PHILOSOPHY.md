# Aftercare Philosophy

## Core thesis

The dominant failure mode of AI coding is no longer syntactic correctness.
It is **structural degradation under successful delivery pressure**.

A feature can satisfy the ticket and still weaken the codebase.
That is the terrain Aftercare is built for.

## Principles

### 1. Preserve working behavior
Refactors exist to improve the future without breaking the present.
The first duty of Aftercare is behavioral preservation.

### 2. Prefer clarity over cleverness
If a structure only makes sense after explanation, it is already too expensive.

### 3. Optimize for the next engineer
The best structure is the one that makes the next change obvious.

### 4. Fix drift in the smallest safe slice
Large rewrites hide risk.
Aftercare prefers staged improvement.

### 5. Distinguish architecture from style
Spacing and naming are cheap.
Boundary leaks, orchestration sprawl, and utility dumping grounds are not.

### 6. Review in business context
Not every awkwardness is a blocker.
A fast-moving prototype and a revenue-critical service deserve different recommendations.

### 7. Every criticism must cash out into action
"This feels messy" is not enough.
A valid finding must identify:

- what is wrong
- why it matters
- what should change
- what the safest next step is

### 8. The goal is governance, not purity
Aftercare is not trying to produce textbook architecture.
It is trying to produce codebases that stay workable under real delivery pressure.

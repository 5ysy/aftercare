# Evaluation

A good Aftercare release should improve host behavior on these dimensions:

## 1. Finding quality

Can the host reliably spot:

- boundary leaks
- responsibility sprawl
- utility dumping grounds
- unnecessary shared abstractions
- pipeline fragility
- missing observability
- risky merge decisions

## 2. Recommendation quality

Does the host propose:

- small safe refactors
- file-level movement plans
- realistic deferrals
- proportionate responses to the repo stage

## 3. Report usefulness

Would a human engineer actually act on the report?

## 4. False-positive control

Does Aftercare avoid dramatic recommendations when the current context does not justify them?

## 5. Cross-host portability

Do the skills still make sense in Claude Code, OpenCode, and future agent hosts?

## Suggested benchmark set

Build a small corpus of anonymized diffs covering:

- healthy feature growth
- subtle boundary leaks
- shared util abuse
- async pipeline fragility
- over-abstracted early code
- under-structured mature code

# Architecture Review Report Template

Extends the review-report format in [`../../references/report-templates.md`](../../references/report-templates.md) with architecture-specific sections. Use this for any architecture-review output.

```markdown
# Architecture Review: [Feature or Change Name]

## Summary
[One paragraph: what was reviewed, the overall structural posture, the single most important finding.]

## Scope
- **Change under review:** [diff, PR, or branch]
- **Feature traced end-to-end:** [the feature you followed from entry point to storage]
- **Files touched:** [N files across M top-level folders]

## Structural map
Briefly list, for the feature under review, where each responsibility lives now:

- **Entry point:** [file]
- **Orchestration:** [file, or "absent — inlined in entry point"]
- **Domain logic:** [file(s)]
- **Infrastructure adapters:** [file(s)]
- **Tests:** [file(s) and what they pin down]

## Findings

Each finding uses this shape:

### [Title — short, descriptive]
- **Severity:** Critical | High | Medium | Low
- **Principle violated:** [from `../../references/engineering-principles.md`]
- **Anti-pattern match (if any):** [from `anti-patterns.md` or `../../references/anti-patterns.md`]
- **Observation:** [the specific code or structural fact — file paths, import direction, concrete example]
- **Cost:** [the specific next change this will make harder, with a name]
- **Smallest repair:** [what to change, scoped narrowly]

### Critical
- [...]

### High
- [...]

### Medium
- [...]

### Low
- [...]

## Why It Matters
[Tie the set of findings to concrete future-change cost, not aesthetic preference.]

## Recommended Next Action
[One of: merge now with no action / merge with tracked follow-ups / hand off to refactor-planning / hold for immediate repair.]

## Verdict
[safe to merge | merge with follow-up | hold for refactor]
```

## Notes

- Every finding cites a principle. If you cannot cite one, you are probably expressing preference.
- Every finding names a concrete future change that will hurt. "Will be harder to maintain" is not concrete; "adding a second payment provider will require changes in the controller, two adapters, and the shared types module" is.
- If the recommended action is a multi-phase refactor, stop writing this report and hand off to [`../refactor-planning/SKILL.md`](../refactor-planning/SKILL.md).

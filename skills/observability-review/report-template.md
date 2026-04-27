# Observability Review Report Template

Extends the review report in [`../../references/report-templates.md`](../../references/report-templates.md) with observability-specific sections. Use this when the primary concern of the review is operator visibility; otherwise use the base review-report template and include the Scenarios section below inline.

```markdown
# Observability Review: [Surface or Change Name]

## Summary
[One paragraph: what was reviewed, what the overall visibility posture looks like.]

## Risky surfaces reviewed
- [surface 1 — what it does, why it is risky]
- [surface 2 — ...]

## Findings

### Critical
- [silent failure on critical path, or similar]

### High
- [retry exhaustion invisible, missing correlation on async handoff, etc.]

### Medium
- [metric exists but lacks labels, inconsistent log levels, etc.]

### Low
- [nice-to-have debug logs, minor cleanup]

## Debugging scenarios
For each High or Critical finding, describe the concrete failure mode:

- **Scenario:** [specific failure, e.g., "downstream API returns 503 intermittently"]
- **Current visibility:** [what the on-call would actually see]
- **Debugging cost:** [what they would have to do]
- **Proposed fix:** [smallest change that closes the gap]

## Why It Matters
[Tie the gaps to operational cost, not to general best practice.]

## Recommended Next Action
[Most appropriate next move — e.g., "add structured error context on the retry loop before merge; defer metric additions."]

## Verdict
[safe to merge | merge with observability follow-up | hold until critical gaps closed]
```

## Notes

- Keep scenarios specific. "Errors might be hard to debug" is not a finding; "when the queue consumer times out, the only trace is a generic `Exception` with no job ID" is.
- Do not expand scope to unchanged surfaces unless the change made them materially more risky.

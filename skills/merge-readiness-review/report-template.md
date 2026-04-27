# Merge Readiness Report Template

Extends the review-report format in [`../../references/report-templates.md`](../../references/report-templates.md). Use this for every merge-readiness verdict.

```markdown
# Merge Readiness: [Change Title]

## Change
- **PR / branch:** [link]
- **Summary:** [one or two sentences — what the change does]
- **Scope coherence:** [single concern | split needed]

## Inputs
- **Prior reviews:** [list review reports consulted: architecture, boundary, pipeline, observability, dependency]
- **Test state:** [green | flaky in area X | failing in area Y]
- **Handled feedback:** [link to the handling-review-feedback summary, if applicable]

## Finding state

### Resolved
- [finding title, prior severity] — [how it was resolved]
- [...]

### Deferred (tracked)
- [finding title, prior severity] — owner: [name]; trigger: [concrete condition]; tracker: [link]; reason: [one sentence]
- [...]

### Unresolved
- [finding title, severity] — [status: still open, no tracked follow-up]
- [...]

## Verdict
**[safe to merge | merge with follow-up | hold for refactor]**

## Risk accounting
[One sentence, per the `rubric.md` pattern for the chosen verdict. Name the specific risk accepted or deferred, with owner and trigger.]

## Why this verdict, not another
- **Not [other verdict]** because [specific condition from `rubric.md` that does or does not apply].
- If the verdict is close, name what would flip it: "this would be `hold` if [condition]; this would be `safe to merge` if [condition]."

## Action
- If **safe to merge:** merge; no further action.
- If **merge with follow-up:** merge; confirm each deferred finding's tracker entry exists before the PR is closed.
- If **hold:** the specific next step that unblocks merging — "address finding X" or "split the change."
```

## Notes

- The verdict is one of exactly three strings. No qualifiers, no "probably safe," no "mostly fine."
- Every deferred finding has an owner, trigger, and tracker link. If any is missing, it is unresolved, not deferred.
- The "Why this verdict, not another" section is load-bearing. It prevents the review from being a rubber stamp.

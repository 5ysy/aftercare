# Report Templates

## Review report

```markdown
# [Review Title]

## Summary
[One paragraph]

## Findings
### Critical
- [issue]

### High
- [issue]

### Medium
- [issue]

### Low
- [issue]

## Why It Matters
[Connect findings to risk or future change cost]

## Recommended Next Action
[Most appropriate next move]

## Verdict
[safe to merge | merge with follow-up | hold for refactor]
```

## Refactor plan

```markdown
# [Refactor Title]

## Goal
[What improves without changing behavior]

## Constraints
- Preserve external behavior
- Keep steps independently verifiable

## Phase 1
- [ ] [small safe step]

## Phase 2
- [ ] [small safe step]

## Verification
- [ ] [tests]
- [ ] [manual checks]
```

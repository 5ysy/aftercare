# Workflows

## Primary workflow: review before done

1. Implementation exists.
2. Run relevant review skills.
3. Group findings by severity.
4. Decide whether to plan refactor now.
5. If yes, use `refactor-planning`.
6. Execute in safe increments.
7. Re-run review if structure changed materially.
8. Run `merge-readiness-review`.

## Conditional workflow: only some skills are needed

### If the diff added or moved folders
Run `project-structure-review`.

### If the diff introduced orchestration or async stages
Run `pipeline-review`.

### If the diff added shared modules or new dependencies
Run `dependency-governance`.

### If the diff changed logging, metrics, retries, error handling, jobs, or background work
Run `observability-review`.

### If the diff is mostly safe code movement or structural cleanup
Run `test-hardening` before executing refactors.

## Escalation rule

If any review finds a likely production incident path, data integrity risk, or severe future-change cost, do not call the work done until there is either:

- a direct fix, or
- an explicit human decision to defer

## Merge verdicts

Use one of three conclusions:

- `safe to merge`
- `merge with follow-up`
- `hold for refactor`

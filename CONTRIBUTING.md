# Contributing

Thanks for helping improve Aftercare.

## What belongs here

Additions should strengthen one or more of these goals:

- better post-development review quality
- more concrete refactor planning
- clearer architecture judgment
- stronger examples and scenario coverage
- lower-friction host integration

## Contribution rules

1. Prefer small, opinionated improvements.
2. Do not add generic advice that every model already knows.
3. Every new skill must teach behavior the host would not reliably discover on its own.
4. If you add a rule, show how it changes outputs.
5. If you add a scenario guide, ground it in specific trade-offs.

## Skill authoring checklist

When adding or editing a skill:

- keep the frontmatter description precise
- define the trigger conditions clearly
- prefer imperative instructions
- include concrete output expectations
- link directly to the relevant references from `references/`
- avoid creating giant monolithic skills

## Review standard

Every contribution should answer these questions:

- Does it make the host more reliable?
- Does it reduce post-dev architecture drift?
- Is it specific enough to matter?
- Is it scoped tightly enough to remain usable?

## Suggested workflow

1. Fork the repository.
2. Create a feature branch.
3. Make a focused change.
4. Update or add examples if behavior changes.
5. Open a PR with:
   - the problem
   - the intended host behavior change
   - before/after example output if relevant

## Good first contributions

- add one new scenario section to `references/business-scenarios.md`
- improve wording in one skill description so hosts trigger it more reliably
- add one realistic example report
- improve merge gating guidance for a specific stack

## Running skill validation

Before opening a PR, run the smoke test from the repo root:

```bash
bash tests/smoke.sh
```

This wraps `scripts/validate-skills.sh`, which enforces:

- every `skills/*/SKILL.md` has frontmatter `name` matching its directory
- every skill has a non-empty `description`
- every sub-file inside a skill directory is referenced by relative path from its SKILL.md
- every relative markdown link inside skill files resolves (fenced code blocks are skipped so pedagogical examples don't fail)
- every `docs/*.md` listed in `README.md`'s Repository-layout tree exists
- the skill table in `AGENTS.md` lists every directory under `skills/`

Exit code 0 means pass. Any failure prints a `FAIL` line identifying the specific issue. Fix those before pushing.

If you add, rename, or remove a skill, you must also update the skill tables in both `README.md` and `AGENTS.md` — the validator will fail on drift.

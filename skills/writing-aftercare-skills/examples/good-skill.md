# Example: A well-written small skill

This is a complete moderate-tier skill you can copy and adapt. It is fictional — `naming-review` is not a real aftercare skill — but it follows every rule in [`../checklist.md`](../checklist.md).

Inline comments (`// like this`) explain why each part looks the way it does. Delete them in your real skill.

---

## `skills/naming-review/SKILL.md`

```markdown
---
name: naming-review
description: use when module, file, or public-function names no longer match the product model. trigger after a feature merges if new code introduced unfamiliar terms, after a rename-heavy refactor, or when a reader needs to hold a glossary in their head to navigate the repo.
---
// Triggers are concrete: "after a feature merges", "after a rename-heavy refactor",
// "when a reader needs to hold a glossary". An agent reading only the frontmatter
// can decide whether this skill applies.

# Naming Review

Announce at the start: "I'm using naming-review to check whether the code vocabulary still matches the product model."

## What to inspect

- Module and directory names at the top two levels.
- Public function and class names exported across package boundaries.
- Database table and column names referenced from multiple services.
- Domain terms used in comments vs names used in code.

## Review method

1. List the product's domain terms (from the spec, README, or recent PRs).
2. Sample 10–20 code names from the inspection surface above.
3. Classify each code name: matches a domain term, is a neutral technical term, or invents a new term.
4. Flag names in the third category. Use [`../../../references/severity-model.md`](../../../references/severity-model.md) for severity.

## Do not

- Rename on sight. Propose renames in a refactor plan; do not perform them in this skill.
- Flag local variables. Only names that cross a boundary count.

## Supporting files

- [`checklist.md`](./checklist.md) — the step-by-step inspection.
- [`anti-patterns.md`](./anti-patterns.md) — naming-specific red flags.

## Output

Use the review report format in [`../../../references/report-templates.md`](../../../references/report-templates.md).
Group findings by "invented terms", "drifted terms", and "shadowed terms".
```

---

## Why this skill is well-written

- **Description contains triggers, not a summary.** An agent can decide from the description alone whether to invoke.
- **Body is ~25 lines.** Well under the 80-line cap. Everything above that cap would go into the sub-files.
- **Tier is moderate.** Two sub-files (`checklist.md`, `anti-patterns.md`) — matching the rubric for a skill with a narrow but non-trivial inspection method.
- **No duplicated references.** The skill links to `severity-model.md` and `report-templates.md`; it does not reprint them.
- **Imperative instructions.** "List", "Sample", "Classify", "Flag" — not "you might consider".
- **Announces itself.** The agent says out loud that it is using the skill, which matters for user transparency and for skill-stacking.
- **"Do not" section is short and specific.** It names the two most likely misuses.

---

## Related

See [`bad-skill.md`](./bad-skill.md) for the same skill written badly, with the specific violations called out.

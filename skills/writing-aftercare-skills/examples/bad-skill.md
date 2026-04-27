# Example: The same skill, written badly

Same fictional skill as [`good-skill.md`](./good-skill.md). Every violation is flagged in `<!-- -->` comments — do NOT leave those comments in a real contribution; they are here for teaching.

---

## `skills/naming-review/SKILL.md` (bad)

```markdown
---
name: naming
<!-- ❌ Violation: `name` does not match the directory. Must be `naming-review`. -->
description: reviews names
<!-- ❌ Violation: No activation triggers. An agent cannot decide when to invoke this.
     Description is a summary of the body, which is exactly what the checklist forbids. -->
---

# Naming Review Skill

<!-- ❌ Violation: no announce-at-the-start line. Users won't see the skill firing. -->

## Overview

Names matter. Good names make code readable and bad names make code unreadable.
Research has shown that engineers spend most of their time reading code rather than writing it,
so picking the right names is one of the most important things a codebase can do.
<!-- ❌ Violation: teaches nothing. Any agent knows names matter. Burn this paragraph. -->

## Severity Model

- **Critical**: likely production failure, data loss, or security exposure.
- **High**: strong architecture drift or boundary damage.
- **Medium**: meaningful maintainability issue.
- **Low**: useful cleanup.
<!-- ❌ Violation: duplicates `references/severity-model.md`. Link, do not copy.
     When severity-model.md is updated, this copy will silently go stale. -->

## Anti-Patterns

### Controller-as-service
HTTP/controller layer contains business decisions.
### Shared-utils sinkhole
A generic shared folder quietly becomes the largest module in the repo.
### (...20 more lines copied from references/anti-patterns.md...)
<!-- ❌ Violation: duplicates `references/anti-patterns.md` wholesale AND none of these
     are naming-specific. A skill-level anti-patterns file must extend, not reprint. -->

## What to Do

You might want to consider looking at names that seem odd. It could be helpful to
think about whether the names match the domain. If you feel that a name is wrong,
you may wish to flag it.
<!-- ❌ Violation: non-imperative, hedging language. Rewrite as "List", "Classify", "Flag". -->

## Process

(...60 lines of detailed inspection steps inline...)
<!-- ❌ Violation: SKILL.md body exceeds 80 lines. Detailed steps belong in checklist.md. -->

## Helpers

See also `naming-helpers.md` and `naming-notes.md`.
<!-- ❌ Violation: references files that don't exist in the skill directory (broken links)
     AND uses non-canonical sub-file names (`helpers`, `notes`). Canonical names would be
     `checklist.md` and `anti-patterns.md`. -->
```

And in the directory, alongside this SKILL.md:

```
skills/naming-review/
├── SKILL.md
├── orphan-notes.md        <!-- ❌ Orphan: not referenced from SKILL.md. Validator fails. -->
└── checklist.md           <!-- ❌ Exists but SKILL.md doesn't link to it. Validator fails. -->
```

---

## Summary of violations

| # | Rule broken | Where to fix |
| --- | --- | --- |
| 1 | `name` ≠ directory | frontmatter |
| 2 | no activation triggers in description | frontmatter |
| 3 | no announce-at-the-start line | body |
| 4 | body teaches nothing | cut the "Overview" paragraph |
| 5 | duplicates `references/severity-model.md` | delete and link |
| 6 | duplicates `references/anti-patterns.md` | rewrite as naming-specific deltas |
| 7 | hedging, non-imperative instructions | rewrite as commands |
| 8 | body > 80 lines | move steps to `checklist.md` |
| 9 | references non-existent sub-files | link to real files or remove |
| 10 | non-canonical sub-file names | rename to `checklist.md`, `anti-patterns.md` |
| 11 | orphan sub-file not referenced from SKILL.md | reference it or delete it |
| 12 | existing sub-file not referenced from SKILL.md | add the link |

Fix all 12, and the skill looks like [`good-skill.md`](./good-skill.md).

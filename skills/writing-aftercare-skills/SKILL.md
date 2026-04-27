---
name: writing-aftercare-skills
description: use when creating a new aftercare skill, editing an existing one, or reviewing a contribution PR. trigger before committing any change under `skills/` so the library stays coherent, activation-ready, and proportional in depth. also trigger when promoting a skill from lean to moderate or moderate to heavy tier.
---

# Writing Aftercare Skills

Announce at the start: "I'm using writing-aftercare-skills to keep this contribution aligned with the library's standards."

## Core idea

An aftercare skill exists to improve agent **judgment** during post-development work. A skill that does not change what an agent would otherwise do is dead weight. A skill that dumps a wall of detail into `SKILL.md` buries the trigger and will not fire reliably.

Two knobs matter most:

1. **Frontmatter `description`** — whether the host agent decides to invoke this skill at all.
2. **Tier of depth** — how much supporting material lives alongside `SKILL.md`.

## Workflow

1. Choose the tier using [`rubric.md`](./rubric.md). Lean skills have 0 sub-files. Moderate skills have 1–2. Heavy skills have 3+.
2. Draft `SKILL.md` from [`examples/good-skill.md`](./examples/good-skill.md). Keep body ≤ 80 lines.
3. Write the frontmatter description last, after the body is clear. It must contain at least one activation trigger phrase (see the checklist).
4. Add sub-files only for content the body would otherwise bloat with. Use the canonical vocabulary: `checklist.md`, `anti-patterns.md`, `examples/`, `decision-tree.md`, `report-template.md`, `rubric.md`, `scripts/`.
5. Every sub-file you add must be referenced by relative path from `SKILL.md`. Orphan files fail validation.
6. Any `anti-patterns.md`, `report-template.md`, or `rubric.md` must open with a link to the corresponding file in `references/` and then add only skill-specific deltas.
7. Run [`checklist.md`](./checklist.md) top-to-bottom before committing.
8. Run the repo validator: `bash scripts/validate-skills.sh`. Fix everything it reports.

## Rules

- Teach non-obvious behavior. If a skill's content is what any competent agent would already do, delete it.
- Keep descriptions trigger-rich. Name situations, symptoms, and user phrasings that should activate the skill.
- Keep instructions imperative. "Do X", not "You might consider X".
- Do not duplicate `references/`. Link and extend.
- Do not rename or remove existing skill directories. Host configs depend on paths.

## Do not

- Pad a skill with boilerplate to make it feel substantial. Lean is a legitimate tier.
- Copy the full severity rubric, anti-patterns list, or report template into a skill sub-file. Link them.
- Write a description that is a summary of the body. Write a description that is a set of triggers.

## Supporting files

- [`checklist.md`](./checklist.md) — authoring and review checklist. Run before every commit.
- [`rubric.md`](./rubric.md) — tier selection (lean / moderate / heavy) with concrete criteria.
- [`anti-patterns.md`](./anti-patterns.md) — authoring-specific anti-patterns, extending `references/anti-patterns.md`.
- [`examples/good-skill.md`](./examples/good-skill.md) — a complete small skill you can copy and adapt.
- [`examples/bad-skill.md`](./examples/bad-skill.md) — the same skill written badly, with inline commentary on what to fix.

## Output

A pull request that:

- adds or edits one skill,
- passes `bash scripts/validate-skills.sh`,
- explains in the PR body which tier was chosen and why.

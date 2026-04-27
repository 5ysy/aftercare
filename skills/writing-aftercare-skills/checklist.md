# Writing Aftercare Skills — Checklist

Run this before committing any change under `skills/`.

## Frontmatter

- [ ] YAML frontmatter is present and parseable.
- [ ] `name` equals the containing directory name exactly (kebab-case).
- [ ] `description` is a single paragraph, 1–3 sentences.
- [ ] `description` starts with a lowercase verb or "use when…" clause.
- [ ] `description` contains at least one concrete activation trigger: a situation ("after feature implementation", "before merge", "during refactor planning"), a symptom ("when a working diff still feels wrong", "when the file tree no longer matches the product model"), or a user phrasing ("reviewing completed code", "proposing a new dependency").
- [ ] `description` does not restate the skill's body. It lists triggers, not steps.

## Body

- [ ] `SKILL.md` body is ≤ 80 lines (excluding frontmatter).
- [ ] First line under the title announces the skill: "Announce at the start: 'I'm using <skill-name> to …'" style.
- [ ] Instructions are imperative and concrete, not aspirational.
- [ ] The body teaches non-obvious behavior. If an average agent would already do what the skill says, cut it.

## Tier

- [ ] Tier chosen intentionally using [`rubric.md`](./rubric.md).
- [ ] Sub-file count matches the tier: lean = 0, moderate = 1–2, heavy = 3+.
- [ ] If the skill is in the heavy tier, it produces or governs structured output (a report, a plan, a verdict) — not just a checklist.

## Sub-files

- [ ] Every sub-file name comes from the canonical vocabulary: `checklist.md`, `anti-patterns.md`, `examples/`, `decision-tree.md`, `report-template.md`, `rubric.md`, `scripts/`.
- [ ] If a novel name is used, `SKILL.md` contains a one-sentence comment explaining why no canonical name fit.
- [ ] Every sub-file is referenced from `SKILL.md` by its relative path. No orphans.
- [ ] `anti-patterns.md` opens with a link to `references/anti-patterns.md` and adds only skill-specific deltas.
- [ ] `report-template.md` opens with a link to `references/report-templates.md` and extends it with skill-specific sections — not a copy.
- [ ] `rubric.md` opens with a link to `references/severity-model.md` and adds only skill-specific severity deltas.
- [ ] `examples/` directory contains at least one concrete case per example file. Each example says what it demonstrates.
- [ ] `decision-tree.md` is either a fenced mermaid/ascii flowchart or a `.dot` file. The skill body references which branches matter.

## Cross-references

- [ ] The skill does not duplicate content from `references/*.md`. It links and extends.
- [ ] Any link to `references/`, `docs/`, or another skill uses a relative path that resolves from the file's location.

## Backward compatibility

- [ ] This change does not rename or delete an existing `skills/<name>/` directory.
- [ ] This change does not move `skills/<name>/SKILL.md` out of its directory.
- [ ] `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`, and `examples/*/` still resolve every path they reference.

## Validation

- [ ] `bash scripts/validate-skills.sh` exits 0.
- [ ] `bash tests/smoke.sh` exits 0.
- [ ] If a new skill was added, it appears in `AGENTS.md`'s skill table and in `README.md`'s skill library table.

## Final sanity pass

- [ ] If you removed the skill, would the agent notice? If no, the skill isn't pulling its weight yet — sharpen the triggers or the body before committing.

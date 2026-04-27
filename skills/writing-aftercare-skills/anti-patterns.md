# Writing Aftercare Skills — Anti-Patterns

Start with the global list in [`../../references/anti-patterns.md`](../../references/anti-patterns.md). The entries below are specific to **authoring skills** and extend that list.

## Vague description

A description that summarizes the body ("this skill reviews naming") instead of naming triggers ("use when module names no longer match the product model"). Vague descriptions do not fire. The skill becomes dead code.

**Fix**: rewrite the description as a list of situations, symptoms, and user phrasings. Test: could an agent decide from the description alone whether to invoke?

## Kitchen-sink SKILL.md

SKILL.md runs past 80 lines and tries to be a reference document, a checklist, an anti-patterns list, and an example set all at once. The trigger is buried. Agents skim and miss the important parts.

**Fix**: move everything except orchestration into sub-files. SKILL.md should feel like a table of contents with short prose, not a textbook.

## References duplication

Copying the severity rubric, the global anti-patterns, or the report template into a skill sub-file. Duplication guarantees drift; the copy will go stale within two edits.

**Fix**: link to `references/*.md` and add only skill-specific deltas underneath. Every skill-level `anti-patterns.md` / `report-template.md` / `rubric.md` must open with "See `references/<file>.md` for the global list; additions below are specific to this skill."

## Sub-file padding

Adding `checklist.md`, `anti-patterns.md`, and `examples/` to a skill that is genuinely narrow, because the author felt every skill should have the same shape. The files end up thin, redundant, or obviously filler.

**Fix**: consult [`rubric.md`](./rubric.md). Lean is a legitimate tier. `using-aftercare` has zero sub-files on purpose.

## Orphan sub-files

A file exists in the skill directory but nothing in `SKILL.md` references it. Either it is dead weight (delete it) or the SKILL.md is out of date (link to it). Either way the validator fails.

**Fix**: before committing, grep SKILL.md for every non-SKILL.md filename in the directory. If one is missing, add the link or remove the file.

## Novel sub-file names

Introducing `notes.md`, `helpers.md`, `tips.md`, or `gotchas.md` when a canonical name (`checklist.md`, `anti-patterns.md`, `decision-tree.md`) would fit. This fragments the library and makes cross-skill navigation harder.

**Fix**: use the canonical vocabulary. If nothing fits, add a one-sentence justification in SKILL.md for the novel name.

## Aspirational instructions

Body text like "you might want to consider", "it could be helpful to", "perhaps look at". Agents trained to be safe will soften this further and end up doing nothing.

**Fix**: use imperatives. "List", "Classify", "Flag", "Propose". If an instruction isn't worth a command verb, it isn't worth including.

## Skill that duplicates what the agent already does

A skill whose content is what any competent coding agent would do anyway (e.g., "read the code before reviewing it"). Adds noise, burns context, erodes trust in the rest of the library.

**Fix**: delete the skill. If the skill's unique value is one paragraph, fold that paragraph into the nearest existing skill instead of creating a new one.

## Host-specific content in skill bodies

Writing "use the Skill tool to load this" or "run `/opsx-apply`" inside a skill body. Skills are host-agnostic; commands and tool names belong in `docs/README.<host>.md`.

**Fix**: keep SKILL.md focused on what to do, not how a specific host invokes it. Link to `docs/README.claude-code.md` or `docs/README.opencode.md` for host mechanics.

## Promoting tier without earning it

Moving a lean skill to moderate, or moderate to heavy, because the author wanted more files. Tier is determined by the skill's actual complexity ([`rubric.md`](./rubric.md)), not by ambition.

**Fix**: if you're tempted to promote, write the new sub-files first as a draft and check whether they say anything the existing SKILL.md doesn't. If not, stay in the current tier.

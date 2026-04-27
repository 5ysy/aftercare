# Changelog

## Unreleased

- Enriched all 13 skills with tier-appropriate sub-files (lean / moderate / heavy), following the uneven-distribution pattern validated in the superpowers project. Every skill now has a focused `SKILL.md` body under 80 lines plus only the sub-files it actually needs (`checklist.md`, `anti-patterns.md`, `report-template.md`, `rubric.md`, `decision-tree.md`, or `examples/`).
- Skill-level `anti-patterns.md`, `report-template.md`, and `rubric.md` files now extend the shared files under `references/` with skill-specific deltas instead of duplicating content.
- Added `AGENTS.md` at repo root — host-agnostic entry point describing when to trigger Aftercare, the core workflow, and the full skill table.
- Added `scripts/validate-skills.sh` structural validator: checks frontmatter, sub-file references, relative-link resolution, README docs layout, and AGENTS.md skill-table drift.
- Added `tests/smoke.sh` as the single validation entry point for contributors and CI.
- Documented validator usage in `CONTRIBUTING.md`.
- Updated `README.md` Repository-layout block to reflect per-skill sub-files and new top-level files (`AGENTS.md`, `scripts/`, `tests/`).

## 0.1.0

- Initial public project scaffold
- Core skill library for post-development architecture governance
- Claude Code plugin manifest and local marketplace files
- OpenCode and Claude Code installation guides
- Review, refactor, and merge-readiness workflow documents
- Example reports and sample host configuration files

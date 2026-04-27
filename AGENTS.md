# AGENTS.md

Host-agnostic guide for coding agents working in this repository.

Aftercare is a skills-first framework for the **post-development** phase — the moment code already works but the repo may have drifted. This document tells any host agent (Claude Code, OpenCode, Gemini CLI, Codex, etc.) how to use the skill library correctly.

For host-specific installation and configuration, see [`docs/README.claude-code.md`](docs/README.claude-code.md) and [`docs/README.opencode.md`](docs/README.opencode.md).

## When to trigger Aftercare

Trigger **after** implementation is done or nearly done. Do not trigger during feature construction.

Typical entry points:

- a feature merges or is about to merge
- a large AI-generated diff just landed
- someone else's completed change is being reviewed
- the question has shifted from "can we build this?" to "did this damage the repo?"

If the user is still writing the feature, Aftercare is the wrong tool — use superpowers or your host's default flow.

## Core workflow

1. **Review completed work** — trigger one or more review skills: `architecture-review`, `boundary-review`, `project-structure-review`, `pipeline-review`, `dependency-governance`, `observability-review`, `test-hardening`.
2. **Plan** — if medium-or-higher findings appear, trigger `refactor-planning` before touching code.
3. **Execute** — only after a plan exists and the human has approved the direction, trigger `executing-incremental-refactors`.
4. **Gate** — before calling work complete, trigger `merge-readiness-review`.

For decision trees and detailed trigger conditions, see [`references/workflow-maps.md`](references/workflow-maps.md) and [`docs/WORKFLOWS.md`](docs/WORKFLOWS.md).

## Skill library

Every skill lives under `skills/<name>/SKILL.md` with optional sub-files in the same directory. Load a skill via your host's skill mechanism (Claude Code `Skill` tool, OpenCode `skill` tool, etc.).

| Skill | Purpose |
| --- | --- |
| `using-aftercare` | Introduces the framework and its decision rules |
| `architecture-review` | Reviews overall structural fit after implementation |
| `boundary-review` | Finds layering and dependency boundary leaks |
| `pipeline-review` | Reviews request, async, data, and agent pipelines |
| `project-structure-review` | Reviews directory layout and module discoverability |
| `dependency-governance` | Reviews new libraries, shared modules, and coupling |
| `observability-review` | Reviews logs, metrics, tracing, and failure visibility |
| `test-hardening` | Adds or refines tests to protect behavior during refactor |
| `refactor-planning` | Turns findings into a staged execution plan |
| `executing-incremental-refactors` | Executes approved plans in small safe slices |
| `merge-readiness-review` | Gives a merge verdict with risk accounting |
| `handling-review-feedback` | Processes AI or human review feedback rigorously |
| `writing-aftercare-skills` | Contributor skill for extending the library |

This table is kept in sync with the `skills/` directory by `scripts/validate-skills.sh`. If you add, rename, or remove a skill, update this table and run the validator before opening a PR.

## Shared references

Skills link to opinionated, reusable material under [`references/`](references/):

- `severity-model.md` — critical / high / medium / low scoring
- `anti-patterns.md` — cross-skill anti-patterns catalog
- `engineering-principles.md` — structural principles applied across reviews
- `report-templates.md` — base templates for review and plan output
- `business-scenarios.md` — stack-specific trade-off notes
- `workflow-maps.md` — when to use which skill in which order

Skill-level `anti-patterns.md`, `report-template.md`, and `rubric.md` files **extend** the corresponding `references/` file with skill-specific deltas — they never duplicate the shared content.

## Rules for agents

1. Do not start writing code as an Aftercare response. Review first, plan second, execute third, gate fourth.
2. When a skill has a checklist, treat it as a todo list, not as optional suggestions.
3. When a skill has a report template, produce the report in that exact shape.
4. When findings are medium-or-higher, stop and propose a plan before making changes.
5. Defer anything the human has not approved; do not autonomously "clean up" adjacent code.
6. Prefer smaller, verifiable slices over dramatic rewrites.
7. Every refactor slice must preserve behavior and re-run relevant tests.

## Validation

- `scripts/validate-skills.sh` — structural checks on the skill library and this file's skill table.
- `tests/smoke.sh` — end-to-end validation entry point; run before opening a PR.

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for how to run them and when.

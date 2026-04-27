<div align="center">

# Aftercare

**Post-development architecture governance for coding agents.**

The discipline layer that runs *after* the code already works.

[![Release](https://img.shields.io/github/v/release/5ysy/aftercare?color=369eff&labelColor=black&style=flat-square)](https://github.com/5ysy/aftercare/releases)
[![License](https://img.shields.io/badge/license-MIT-white?labelColor=black&style=flat-square)](LICENSE)
[![Stars](https://img.shields.io/github/stars/5ysy/aftercare?color=ffcb47&labelColor=black&style=flat-square)](https://github.com/5ysy/aftercare/stargazers)
[![Issues](https://img.shields.io/github/issues/5ysy/aftercare?color=ff80eb&labelColor=black&style=flat-square)](https://github.com/5ysy/aftercare/issues)
[![Contributors](https://img.shields.io/github/contributors/5ysy/aftercare?color=c4f042&labelColor=black&style=flat-square)](https://github.com/5ysy/aftercare/graphs/contributors)

[Claude Code](docs/README.claude-code.md) · [OpenCode](docs/README.opencode.md) · [Workflows](docs/WORKFLOWS.md) · [Philosophy](docs/PHILOSOPHY.md)

**English** | [简体中文](README.zh-CN.md)

</div>

---

## The problem

Most AI coding tools are tuned for the same moment: **going from spec to working code**.

Aftercare is built for a different moment — the one those tools leave behind.

The ticket is closed. The tests pass. CI is green. And yet:

- responsibilities have slid into the wrong layer
- routes and controllers quietly became application services
- shared utilities turned into a dumping ground
- pipelines grew without contracts, retries, or observability
- the file tree no longer matches the product model
- every new feature takes the path of least resistance, not the right path

This is **architecture drift**. It does not show up in test runs. It shows up six months later, when the next change is three times harder than it should be.

Aftercare is the framework that makes a coding agent slow down, inspect the structure, and convert critique into a staged plan — *before* calling the work complete.

## What Aftercare is

A **skills-first** framework for the post-development phase. It plugs into your existing host (Claude Code, OpenCode, and similar agents) and gives it judgment for:

- architecture review
- boundary review
- project structure review
- pipeline and orchestration review
- dependency governance
- observability review
- test hardening
- incremental refactor planning
- merge readiness decisions

It is **not** another execution-first agent. It does not replace your CLI. It does not deliver framework religion. It teaches your host *how to look at completed work and decide what to do next*.

## Highlights

|       | Capability                          | What it does                                                                                              |
| :---: | :---------------------------------- | :-------------------------------------------------------------------------------------------------------- |
|   🔍   | **Review skills**                   | Seven structured reviews: architecture, boundary, structure, pipeline, deps, observability, tests.        |
|   📐   | **Severity model**                  | Critical / high / medium / low scoring so blockers separate cleanly from backlog cleanup.                 |
|   🧭   | **Workflow maps**                   | Decision trees for *which skill, in which order*. No more guessing where to start.                        |
|   🧱   | **Refactor planning**               | Findings convert into staged, behavior-preserving plans before any code is touched.                       |
|   ✂️   | **Incremental execution**           | Refactors run in small verifiable slices. Each slice re-runs tests and stays reversible.                  |
|   🛂   | **Merge readiness gate**            | A structured verdict (proceed / fix-then-merge / hold) with risk accounting before integration.           |
|   📋   | **Report templates**                | Every review produces output in a consistent, reviewable shape — not vague prose.                         |
|   🧩   | **Host-agnostic**                   | First-class support for Claude Code and OpenCode. Other skill-aware hosts work the same way.              |
|   🧠   | **Opinionated references**          | Shared anti-patterns, engineering principles, and severity rubrics — extended by each skill, not copied.  |
|   🪶   | **Drop-in**                         | Pure markdown skills + small plugin manifest. No build step. No runtime. No lock-in.                      |

## Why this exists

AI-generated code usually fails in one of two ways:

1. It is locally correct but globally messy.
2. It solves the ticket while quietly degrading the repo.

The deeper problem is not "bad code" — it is **structural degradation under successful delivery pressure**. A feature can satisfy its acceptance criteria and still weaken the codebase that hosts it.

Aftercare exists because *that* is the terrain where current agents are weakest, and where the cost of getting it wrong compounds the longest.

## Core workflow

```
                  ┌─────────────────────────────┐
   completed work │ 1. Review                   │
   ────────────► │   architecture-review       │
                  │   boundary-review           │
                  │   project-structure-review  │
                  │   pipeline-review           │
                  │   dependency-governance     │
                  │   observability-review      │
                  │   test-hardening            │
                  └──────────────┬──────────────┘
                                 │ medium-or-higher findings?
                                 ▼
                  ┌─────────────────────────────┐
                  │ 2. Plan                     │
                  │   refactor-planning         │
                  └──────────────┬──────────────┘
                                 │ approved direction
                                 ▼
                  ┌─────────────────────────────┐
                  │ 3. Execute                  │
                  │   executing-incremental-    │
                  │   refactors                 │
                  └──────────────┬──────────────┘
                                 ▼
                  ┌─────────────────────────────┐
                  │ 4. Gate                     │
                  │   merge-readiness-review    │
                  └─────────────────────────────┘
```

Detailed decision trees live in [`references/workflow-maps.md`](references/workflow-maps.md) and [`docs/WORKFLOWS.md`](docs/WORKFLOWS.md).

## Skill library

Every skill lives at `skills/<name>/SKILL.md` with optional sub-files in the same directory.

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

## Installation

### Claude Code

See [`docs/README.claude-code.md`](docs/README.claude-code.md).

### OpenCode

See [`docs/README.opencode.md`](docs/README.opencode.md).

### One-line agent prompt

If you would rather let your agent do the install, give it this:

```
Install Aftercare into this repository by following the host-specific guide
under docs/ in https://github.com/5ysy/aftercare. Pick the file that
matches my coding agent (Claude Code or OpenCode) and follow it exactly.
```

## Example prompts

Once installed, drive Aftercare from your existing host:

- "Review my current changes with Aftercare before I call this done."
- "Use Aftercare to check whether this feature introduced boundary leaks."
- "Run project structure review and tell me what should move."
- "Turn your findings into an incremental refactor plan."
- "Before merge, run Aftercare merge readiness review on this diff."

## Design goals

1. Preserve working behavior.
2. Prefer small safe refactors over dramatic rewrites.
3. Treat code structure as a first-class product concern.
4. Distinguish blockers from backlog cleanup.
5. Produce actionable plans, not vague criticism.
6. Work across multiple host agents.
7. Be useful in existing codebases, not only clean greenfield projects.

## Repository layout

```text
aftercare/
├── AGENTS.md                       # host-agnostic agent guide
├── .claude-plugin/                 # Claude Code plugin manifest
├── agents/                         # specialized reviewer/planner agents
├── docs/                           # architecture, workflows, host guides
├── examples/                       # real reports, plans, host configs
├── references/                     # severity model, anti-patterns, principles
├── scripts/validate-skills.sh      # structural validator
├── skills/<name>/SKILL.md          # the skill library
└── tests/smoke.sh                  # end-to-end validation entry point
```

## Adoption

### Personal
Install globally. Run Aftercare after every non-trivial feature, before merge, and after large AI-generated diffs.

### Team
- agree on which findings are blockers
- standardize on a single merge-verdict format
- mark which skills are mandatory before merge
- contribute real reports back as `examples/`

### Org
- distribute via marketplace or plugin channel
- maintain stack-specific scenario notes under `references/business-scenarios.md`
- track architecture drift over time, not just per-PR pass/fail

## Validation

- `scripts/validate-skills.sh` — structural checks on the skill library and on this README's skill table
- `tests/smoke.sh` — end-to-end validation; run before opening a PR

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for the full contributor flow.

## What Aftercare is **not**

- not another execution-first coding agent
- not a replacement for your host CLI
- not a one-size-fits-all architecture scoring bot
- not a framework religion delivery system

Aftercare assumes your host already knows how to read files, write code, run tests, and use the shell. Its only job is to teach the host **judgment** for the post-development phase.

## License

MIT. See [LICENSE](LICENSE).

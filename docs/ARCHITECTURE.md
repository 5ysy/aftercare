# Architecture

## Project architecture

Aftercare is a skills-first repository with optional host-specific affordances.

### Layers

1. **Skills**
   - Core behavior library
   - Primary unit of reuse
   - Portable across hosts

2. **References**
   - Opinionated supporting documents
   - Severity model
   - Anti-pattern catalog
   - Scenario guidance
   - Report templates

3. **Agents**
   - Optional specialist personas
   - Especially useful in Claude Code and OpenCode
   - Focus on review, planning, and merge gating

4. **Examples**
   - Host configuration examples
   - Example reports and plans
   - Helps contributors keep outputs consistent

5. **Plugin metadata**
   - Claude Code plugin manifest
   - Local development marketplace manifest

## Why skills are the center

The host already knows how to execute tools.
The thing it lacks is structured judgment about architecture and maintenance trade-offs.
That judgment belongs in the skills.

## Trigger model

The host should reach for Aftercare in three broad situations:

### 1. Post-implementation review
Use after code exists and before calling work done.

### 2. Refactor decision
Use when a feature works but the implementation path created design debt.

### 3. Merge gate
Use before merge to separate blockers from follow-up work.

## Host support model

### Claude Code
- native plugin manifest at `.claude-plugin/plugin.json`
- skills auto-discovered by Claude plugin system
- optional specialist agents in `agents/`

### OpenCode
- install skills in an official discovery path
- optionally register review/planning agents via OpenCode config
- use commands or explicit prompts to trigger review flow

## Extension strategy

Keep the skills stable and portable.
Keep host-specific configuration thin.
Avoid putting too much logic into any single host adapter.

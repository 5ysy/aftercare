# Aftercare for Claude Code

## What you get

Installing Aftercare in Claude Code gives you:

- automatic access to the Aftercare skill library
- optional specialist subagents for review and planning
- a reusable local marketplace config for development

## Local development install

From inside the cloned repo:

1. Start Claude Code.
2. Add the local marketplace:

```text
/plugin marketplace add .
```

3. Install the plugin:

```text
/plugin install aftercare@aftercare-dev
```

4. Restart Claude Code.

## Repository plugin structure

This repo already includes:

- `.claude-plugin/plugin.json`
- `.claude-plugin/marketplace.json`
- `skills/`
- `agents/`

That means it can be used directly as a local development plugin repository.

## Suggested usage

After implementing a feature, ask Claude:

- "Use Aftercare to review my current changes."
- "Run Aftercare merge readiness review on this branch."
- "Turn the Aftercare findings into an incremental refactor plan."

## Project-level reinforcement

For important repos, add project instructions that explicitly require an Aftercare review before merge or before declaring work complete.

## Publishing later

Once the plugin stabilizes:

- publish a dedicated marketplace repo, or
- submit the plugin to an existing marketplace

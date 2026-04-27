# Aftercare for OpenCode

## What you get

OpenCode can use Aftercare through its native skill and agent discovery paths.

## Recommended install: global skills

Clone the repo somewhere stable, then link the `skills/` directory into one of OpenCode's official skill locations.

Example:

```bash
git clone https://github.com/your-org/aftercare.git ~/.config/aftercare
mkdir -p ~/.config/opencode
ln -s ~/.config/aftercare/skills ~/.config/opencode/skills
```

If you already manage skills through Claude-compatible or agent-compatible paths, use one of those instead.

## Optional: custom agents

OpenCode can also define specialized agents through config. See:

- `examples/opencode/opencode.json`

Recommended agents:

- `aftercare-reviewer`
- `aftercare-planner`
- `aftercare-merge-gate`

## Project-local install

If a team wants Aftercare only for one repo, copy or symlink the desired skills into:

- `.opencode/skills/`

and optionally agent definitions into:

- `.opencode/agents/`

## Suggested workflow

1. Build the feature normally.
2. Ask for Aftercare review.
3. If findings are medium-or-higher, trigger `refactor-planning`.
4. Apply approved fixes in small slices.
5. Run `merge-readiness-review`.

## Notes

Aftercare is intentionally skills-first.
It does not try to replace OpenCode's own planning/build capabilities.
It augments them with stronger post-development judgment.

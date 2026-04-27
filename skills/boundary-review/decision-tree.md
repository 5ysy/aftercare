# Boundary Violation vs Style Preference — Decision Tree

Use this when a crossing looks ugly but you are not sure whether it is a real finding.

## 1. Is the boundary explicit?

- **Yes — there is a layering convention, a package interface, an ownership line, an import-lint rule, or a stated architecture in the repo.**
  → Go to 2.
- **No — the "boundary" only exists in your head.**
  → This is not a finding against the change. It may be worth raising as a structural ambiguity in the repo: "there is no explicit boundary between X and Y, and this change reveals the cost of that." Do not dress it as a violation.

## 2. Does the crossing reverse the intended direction, or reach into internals?

- **Yes — backflow or reach-through.** → This is a **violation.** Go to 4 to set severity.
- **No — the direction is correct and the crossing is through a sanctioned surface.** → Go to 3.

## 3. Does the crossing couple things that are supposed to be independent?

- **Yes — cross-feature internals, shared-module bridge, policy-in-adapter, transport-type-in-domain.** → This is a **violation.** Go to 4.
- **No — the crossing is a legitimate use of the provider's public surface.** → This is not a finding. If it is still ugly, capture as a Low note at most; do not inflate.

## 4. Severity

Name a specific next change on either side of the boundary:

- **The next change is concrete, planned, and the crossing will materially hurt it** → **High or Critical** (Critical if the crossing actively risks correctness or production).
- **The next change is speculative but plausible, and the crossing adds real coupling** → **High** if the coupling is broad; **Medium** if narrow.
- **No plausible next change is harmed; the crossing is technically a leak but structurally inert** → **Low** or do not flag.

## 5. Style-preference test

Before flagging, ask:

- Would I have flagged this crossing if it looked the way I prefer, but had the same import graph and behavior?
- If no — you were reacting to style, not structure. Drop the finding.
- If yes — write the finding with the import graph, not the style, as the evidence.

## 6. When two skills could apply

- If the crossing is about **how** information flows through a multi-stage system (retries, stages, async handoff), the concern belongs to [`../pipeline-review/SKILL.md`](../pipeline-review/SKILL.md), not boundary-review.
- If the crossing is about **new dependencies** (a new library, a new shared module), add a cross-reference to [`../dependency-governance/SKILL.md`](../dependency-governance/SKILL.md); do not reproduce its checks.

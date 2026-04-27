# Boundary Review Checklist

Run per boundary crossing introduced or modified by the change.

## 1. Identify the boundary

- [ ] Which boundary does this crossing involve: layer, package, feature, public/internal, ownership?
- [ ] Is the intended direction of dependency across this boundary known and stated elsewhere in the repo?
- [ ] If the direction is not stated, what direction does the rest of the repo imply?

## 2. Direction

- [ ] Does the new import/call go in the intended direction (higher → lower, outer → inner)?
- [ ] Does a lower-level module import from a higher-level one? (dependency backflow)
- [ ] Does the data flow match the import direction, or does data move the other way via shared mutable state?

## 3. Surface

- [ ] If a package or feature is being imported from, is the import through its public surface (explicit exports, `__init__.py`, index module)?
- [ ] Or is it reaching into internal files (`_internal`, deeply nested module paths, private names)?
- [ ] Is the crossing through a named, documented interface, or via convention?

## 4. Ownership

- [ ] Does the crossing make team A's code depend on team B's implementation details?
- [ ] If ownership lines exist, will a change owned by team B now require coordination with team A?
- [ ] Is the crossing opt-in (the owning team published the surface deliberately) or opportunistic (consumer grabbed what was available)?

## 5. Shared modules

- [ ] Does the crossing route through a `shared/`, `common/`, or `core/` location?
- [ ] Does that shared module now know about feature-specific types or behavior?
- [ ] Has the shared module become a de-facto bridge between features that are supposed to be independent?

## 6. Cost check

- [ ] Name one likely next change to either side of this boundary. Does this crossing make it harder or more expensive?
- [ ] If the boundary were to be redrawn, is this crossing one of the things that would resist?
- [ ] Is the crossing reversible (delete one import, move one file) or structural (many call sites, shared types)?

## Verdict per crossing

- **Legitimate** — through the sanctioned surface, correct direction, no feature coupling introduced.
- **Stylistic** — the crossing is ugly or unfamiliar but has no demonstrable cost. Do not flag.
- **Leak** — wrong direction, or through internals, or couples features that should be independent. Flag with severity.

When uncertain, see [`decision-tree.md`](./decision-tree.md).

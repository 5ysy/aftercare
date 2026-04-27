# Dependency Governance Checklist

Run each section against the edges introduced by the change. Skip sections that do not apply.

## 1. New third-party packages

- [ ] Is this package used in more than one call site, or just one?
- [ ] Did the implementer evaluate the alternative of writing 20–50 lines instead?
- [ ] Is the package actively maintained (recent releases, open issues triaged)?
- [ ] Is the package's license compatible with the project?
- [ ] Does it pull a large transitive tree for a small benefit?
- [ ] Is there a clear removal path if it is abandoned?

## 2. New internal shared modules

- [ ] Does it currently have more than one real consumer, or was it created speculatively?
- [ ] Does its name describe what it *is*, not just where it lives (avoid `utils`, `common`, `helpers`, `shared` as leaf names)?
- [ ] Does it own its concept, or is it a convenience dumping ground?
- [ ] If it is a wrapper, does the wrapper genuinely reduce complexity, or does it just rename the underlying API?

## 3. Cross-module coupling

- [ ] Do lower-level modules import higher-level policy or presentation? (dependency backflow)
- [ ] Does a feature now reach into another feature's internals?
- [ ] Has a "shared" location absorbed logic that belongs to exactly one feature?
- [ ] Are the import directions consistent with how the team actually thinks about layers?

## 4. Wrappers around existing libraries

- [ ] Does the wrapper hide complexity, or just forward arguments?
- [ ] Does it prevent the team from using library features they will eventually need?
- [ ] Does it create a second, parallel vocabulary for the same concept?

## 5. Ownership and reversibility

- [ ] Is there a named owner (person, team, or module) for each new dependency?
- [ ] Could the dependency be removed in a future change without a rewrite?
- [ ] Is the dependency's failure mode understood (what breaks if it is unavailable or buggy)?

## Verdict per edge

For each edge, record one of:

- **Justified** — clear benefit, clear ownership, reversible.
- **Risky but acceptable** — adds coupling but buys real capability; note the risk.
- **Remove or defer** — the cost exceeds the benefit, or the abstraction is premature.

# Bad Architecture Review Example

The same change as [`good-report.md`](./good-report.md), reviewed badly. Every finding below is ungrounded — taste, vague worry, or textbook pattern-matching without local cost. Annotations in **[brackets]** point out the specific failures.

---

# Architecture Review: Invoice Generation Extraction

## Summary
This change has a lot of issues. It doesn't follow clean architecture properly and the code is not very maintainable. Several things should be refactored. **[Failure: no specifics. "A lot of issues" is not a summary.]**

## Findings

### Not following clean architecture
- **Severity:** Critical **[Failure: severity per `../../references/severity-model.md` is about cost and risk, not adherence to a pattern. Nothing here threatens production.]**
- **Observation:** The code doesn't have a separate use-case layer or ports/adapters in the canonical sense.
- **Cost:** It will be hard to maintain. **[Failure: no named next change, no concrete cost.]**
- **Smallest repair:** Introduce use-case classes, port interfaces, and DI container wiring. **[Failure: this is a rewrite, not the smallest repair. Refines `../../references/anti-patterns.md` "Rewrite reflex".]**

### Function too long
- **Severity:** High **[Failure: severity inflation. A long function is Low at worst unless it hides a boundary problem.]**
- **Observation:** `generate_invoice` is 40 lines.
- **Cost:** Hard to read. **[Failure: reading cost is not architectural cost. This is a style comment, not architecture.]**
- **Smallest repair:** Split into smaller functions.

### Should use async
- **Severity:** High **[Failure: preference dressed as architecture. The surrounding codebase is synchronous; the review is demanding "idealized layering the repo does not otherwise use".]**
- **Observation:** PDF rendering blocks the request thread.
- **Cost:** Performance. **[Failure: performance claim with no measurement and no stated bottleneck.]**
- **Smallest repair:** Rewrite the service to be async end-to-end.

### Tests could be better
- **Severity:** Medium **[Failure: vague. "Better" how? This is not a finding, it is a feeling.]**
- **Observation:** The test file only has 6 tests.
- **Cost:** N/A **[Failure: no cost means no finding.]**

## Why It Matters
Good architecture matters for long-term maintainability. **[Failure: generic statement. Does not tie to this repo, this change, or any named next change.]**

## Recommended Next Action
Full rewrite following hexagonal architecture. **[Failure: rewrite reflex. The change is a clear local improvement; a rewrite is not the appropriate next step.]**

## Verdict
hold for refactor **[Failure: verdict does not follow from the (ungrounded) findings. The actual change is a net improvement and would be merge-with-follow-up under a grounded review — see `good-report.md`.]**

---

## Lessons

1. Severity is **cost and risk**, not pattern-fidelity.
2. Every finding names **a specific next change** that becomes harder. If you cannot name it, you do not have a finding.
3. "Hard to maintain" and "hard to read" are not architecture findings on their own. They are symptoms that need to be traced to a concrete cost.
4. Do not demand **layering the repo does not otherwise use**. Review against the repo's own contract, not a textbook's.
5. A change that is locally an improvement should not be flagged for not being the idealized endpoint.

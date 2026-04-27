# Test Hardening Checklist

For each behavior the upcoming refactor will move, rename, split, or merge, walk through these questions.

## 1. Is the behavior specified by a test?

- [ ] Is there at least one test whose failure would signal that this behavior changed?
- [ ] Does that test describe the behavior in terms that survive the refactor (inputs/outputs, not internal structure)?
- [ ] Would the test still run, unchanged, after the refactor moves the code?

## 2. Regression coverage

- [ ] Are the current inputs and outputs of this behavior captured by at least one example?
- [ ] Are the non-obvious cases (empty, null, boundary, error) covered?
- [ ] If the behavior has side effects (DB writes, external calls, events emitted), are the important ones asserted?

## 3. Contract coverage at boundaries

- [ ] If the refactor will preserve a public boundary (API, module interface, queue contract), is there a test *at that boundary*?
- [ ] Does the boundary test exercise realistic payloads, not minimal happy-path ones?
- [ ] If the boundary is consumed by another service or module, does a contract test exist on at least one side?

## 4. Branch structure

- [ ] Are the branches the refactor may disturb (conditionals, error paths, feature flags) reached by tests?
- [ ] If a conditional will be removed or inverted, is each current outcome tested?

## 5. Test location

- [ ] Will the new/hardened test still make sense after the code moves?
- [ ] Is it placed high enough in the stack that it does not need rewriting when internals change?
- [ ] If it must live near the implementation, is that acceptance recorded so it is deleted or moved with the refactor?

## 6. Stopping

- [ ] Do the added tests cover the behaviors the refactor plan lists as risky?
- [ ] Would adding more tests now mostly cover code that will change anyway?
- [ ] If you stopped hardening here and the refactor silently changed behavior, would at least one test fail?

When the last answer is "yes" for every listed risky behavior, stop. More coverage is a separate task.

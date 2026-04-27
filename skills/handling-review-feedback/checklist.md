# Review Feedback Processing Checklist

Run per comment. Adjust the weight of AI-generated vs human feedback as noted below, but do not skip steps for either.

## 1. Restate

- [ ] Can I rephrase the comment in my own words, referencing the specific code it applies to?
- [ ] If the comment is vague ("this could be cleaner"), do I know which specific change the reviewer has in mind? If not, ask before deciding.

## 2. Classify

- [ ] Is this about **correctness** — the code is wrong, will break, or violates a contract?
- [ ] Is this about **structure** — the code works but will resist change, mislead readers, or propagate damage?
- [ ] Is this **preference** — a valid alternative the reviewer prefers, with no demonstrable advantage?
- [ ] Is it actually two comments entangled? (Split them before deciding.)

## 3. Verify

- [ ] For correctness claims: is there a failing test, a reproducible scenario, or a clear reading of the code that shows the claim is right?
- [ ] For structure claims: what specific future change would this comment's concern make harder or cheaper? Can I name it?
- [ ] For preference claims: is there any evidence the reviewer's alternative is meaningfully better here, or is this stylistic?

## 4. Weight by source

- [ ] If the comment is AI-generated (aftercare skill, other agent, static analyzer), is the reasoning chain inspectable? Do not accept just because an agent said so; do not dismiss just because an agent said so.
- [ ] If the comment is from a human reviewer with more context on the system, weight structure and preference comments more heavily than you would from an agent — humans often carry context not in the diff.
- [ ] For either source: the correctness bar is identical. Verification is mandatory.

## 5. Decide

- [ ] **Accept now** — act within this change; note the action.
- [ ] **Defer** — track as a follow-up with a specific trigger (next change in this area, next release, named issue); do not use "defer" as a polite "reject."
- [ ] **Reject** — write the reasoning, in one or two sentences, in the summary. Silent rejection is not allowed.

## 6. Act

- [ ] If accepted, is the resulting action the *smallest* change that addresses the claim?
- [ ] Am I resisting the urge to turn a small acceptance into a broader rewrite?
- [ ] Am I resisting the urge to reject multiple related comments together without processing each?

## 7. Summarize

- [ ] Is there a written record (PR comment, change notes) of which comments were accepted, deferred, or rejected, with reasons?
- [ ] Are any Critical or High comments still unresolved? If yes, the change is not ready to merge until they are addressed or explicitly accepted as known risk.

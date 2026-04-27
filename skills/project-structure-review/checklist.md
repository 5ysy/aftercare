# Project Structure Review — Checklist

Run in order. Stop when you have enough findings to fill a report; you do not need to hit every box.

## Top-level orientation

- [ ] List every top-level directory. For each, write one sentence describing its purpose. Any directory that resists a one-sentence purpose is a finding.
- [ ] Is there exactly one obvious entry point (or one per runtime — web, cli, worker)? Hidden or scattered entry points are a finding.
- [ ] Is there a `shared/`, `common/`, `utils/`, `lib/`, or `core/` directory? If yes, measure it (file count, LOC). If it is in the top-3 largest modules, that is a finding.

## Feature tracing

- [ ] Pick one feature touched by the recent change. Identify: entry point, application/service orchestrator, domain logic, infrastructure adapter, test.
- [ ] Count how many top-level folders the trace visits. More than three is a finding unless the layering is intentional and consistent across the repo.
- [ ] Does the feature's code cluster (live in siblings or one parent)? Or is it scattered across unrelated top-level locations? Scatter is a finding.

## Naming and discoverability

- [ ] Could a new engineer find the feature by directory name alone, without grepping? If not, that is a finding.
- [ ] Are directory names nouns matching the product model (`billing/`, `auth/`) or technical categories (`controllers/`, `handlers/`)? Technical-category top-levels in a product repo are a finding when they hide the product model.
- [ ] Do siblings at the same level use consistent naming conventions (all kebab-case, all singular, all plural, etc.)? Inconsistency within one level is a finding.

## Shared locations

- [ ] For the largest shared location, sample 10 files. How many are used by exactly one feature? More than 3 is a finding — the shared location is accumulating private code.
- [ ] Does anything under `shared/` import from a feature-specific module? That is a dependency backflow (Critical/High).
- [ ] Is there a clear rule for when something earns a place in `shared/`? If the rule is implicit, that is a Medium finding.

## Test placement

- [ ] Are tests colocated with the code they test, or centralized? Either is acceptable if consistent. Inconsistency is a finding.
- [ ] Do the tests for the recently changed feature live close to the feature code? If they live far away, future engineers will not update them together — a finding.

## Structure around the change

- [ ] Did the recent change create a new top-level directory? If yes, does it deserve that level, or should it be nested? Unjustified new top-levels are a Medium finding.
- [ ] Did the recent change rename or move existing files? If yes, is the rest of the tree still internally consistent? Partial renames are a finding.
- [ ] Did the recent change add files into an existing `shared/` without a clear owner? That is a finding.

## Final sanity pass

- [ ] If a new engineer joined today and you told them "go make a change in feature X", could they start in under a minute using the file tree alone? If no, the top finding is the structural noise blocking that.
- [ ] Are your proposed fixes small (move a few files) or large (reorganize a tier)? Prefer small. Large reorganizations need their own `refactor-planning` pass.

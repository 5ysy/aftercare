# Architecture Review Checklist

Walk each section against the changed area. Skip sections that do not apply; note when you skip and why.

## 1. Entry points and handlers

- [ ] Do controllers / handlers / route functions coordinate, or do they make business decisions?
- [ ] Is persistence, validation policy, or external-service logic inlined into the entry layer?
- [ ] Can you replace the transport (HTTP → queue, CLI → function) without touching the decision logic?

## 2. Orchestration

- [ ] Is there a named place where multi-step flows are coordinated, separate from both the entry layer and the domain logic?
- [ ] Are stages of the flow explicit, or implicit in call order?
- [ ] Does orchestration own error handling and retries, or is that smeared across layers?

## 3. Domain logic placement

- [ ] Does the domain logic live in named domain modules, or is it scattered across handlers and adapters?
- [ ] Do the domain modules import infrastructure (HTTP, DB, queue) directly? They should not.
- [ ] Is the vocabulary in the domain modules the business's vocabulary, not the framework's?

## 4. Infrastructure adapters

- [ ] Is each external system (DB, queue, external API) behind a narrow named adapter?
- [ ] Do adapters carry business rules that should live in the domain?
- [ ] Are adapter interfaces shaped by the domain's needs, or by the external system's shape?

## 5. Shared modules and utility growth

- [ ] Were any new `shared/`, `common/`, `utils/`, `helpers/` files added?
- [ ] For each, is there more than one real consumer right now?
- [ ] Does any existing shared module own feature-specific logic that should move back to its feature?

## 6. Tests protecting the current shape

- [ ] Do tests assert observable behavior at stable boundaries, or internal structure at volatile ones?
- [ ] If the refactor-suggestion moves code, will the tests still pass without modification?
- [ ] Is there at least one test that would fail if the architectural boundary the change relies on were broken?

## 7. Change-cost thought experiment

- [ ] Imagine the three likely next changes to this area. For each, would the current structure help or hurt?
- [ ] Would a new engineer find the feature end-to-end in under a minute?
- [ ] Is there any "magic" — implicit dependency, hidden side effect, ambient state — introduced by this change?

## Finding framing

For each finding, record: (a) the principle from [`../../references/engineering-principles.md`](../../references/engineering-principles.md) it violates, (b) the specific next change it will make harder, (c) the smallest repair, (d) severity per [`../../references/severity-model.md`](../../references/severity-model.md).

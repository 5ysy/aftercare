# Order Flow Refactor Plan

## Goal
Move orchestration out of the route layer without changing external behavior.

## Constraints
- Preserve request/response shape
- Keep the move independently testable
- Avoid broad shared-module cleanup in the same change

## Phase 1: Stabilize behavior
- [ ] Add regression tests around authorization and invalid transitions.
- [ ] Snapshot or otherwise lock current response semantics for key paths.

## Phase 2: Isolate orchestration
- [ ] Introduce an application-level service for order transition orchestration.
- [ ] Keep persistence adapters unchanged in this phase.

## Phase 3: Remove shared-module leakage
- [ ] Move order-specific helpers out of `shared/utils/orders.ts` into feature-owned code.
- [ ] Leave generic helpers behind only if they remain genuinely generic.

## Verification
- [ ] Run the relevant automated tests
- [ ] Exercise the main happy path manually
- [ ] Re-run Aftercare architecture review

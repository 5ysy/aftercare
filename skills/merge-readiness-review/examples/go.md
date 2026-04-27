# Merge Readiness Example: GO

A "merge with follow-up" verdict on the invoice-extraction scenario after the staged refactor from [`../refactor-planning/examples/staged-plan.md`](../../refactor-planning/examples/staged-plan.md) has completed phases 1–2.

---

# Merge Readiness: Decouple InvoiceService from HTTP transport (phases 1–2)

## Change
- **PR / branch:** #418, branch `refactor/invoice-dto-phase2`
- **Summary:** `InvoiceService.generate_invoice()` now returns a domain `InvoiceResult` DTO; `BillingController` translates it to the existing HTTP response. PDF-bytes contract test hardened.
- **Scope coherence:** single concern (phases 1 and 2 of the approved staged plan).

## Inputs
- **Prior reviews:** `architecture-review/examples/good-report.md`; follow-up refactor plan at `refactor-planning/examples/staged-plan.md`.
- **Test state:** green. `tests/services/test_invoice_pdf_contract.py` new and passing; existing controller and service tests green.
- **Handled feedback:** 3 reviewer comments processed — 2 accepted and acted on in this PR, 1 rejected with one-line reasoning (request to make `InvoiceResult` frozen, rejected because the downstream scheduler mutates it intentionally).

## Finding state

### Resolved
- **Transport type leaked into service layer (High)** — closed. `InvoiceService` no longer imports `FlaskResponse`; returns `InvoiceResult`. Verified by `tests/services/test_invoice_service.py` and by the PDF contract test still passing.

### Deferred (tracked)
- **Orchestration owns PDF rendering details (Medium)** — owner: `#billing-team`; trigger: execute Phase 3 of the staged plan; tracker: issue #431 ("Phase 3: InvoiceTemplate extraction"); reason: this PR is already at ~140 lines and Phase 3 is independently shippable.
- **`utils/money.py` has one caller (Medium)** — owner: `#billing-team`; trigger: execute Phase 4 of the staged plan; tracker: issue #432; reason: same as above, Phase 4 is independently shippable and was deliberately separated.

### Unresolved
- None.

## Verdict
**merge with follow-up**

## Risk accounting
By merging now, we accept that two Medium findings remain open (Phase 3 and Phase 4 of the staged plan). The cost of holding — stalling the High-severity fix and accumulating merge conflicts with ongoing billing work — is higher than the cost of the two deferrals, both of which have concrete tracker entries and a committed owner.

## Why this verdict, not another
- **Not `safe to merge`** because two Medium findings with real structural content are deferred, not closed — the verdict should reflect that tracked follow-up is expected.
- **Not `hold for refactor`** because the High finding is closed, no Critical findings exist, and the deferred Mediums are independently shippable by design of the staged plan. Holding would gain nothing and cost active development time.
- This would flip to `hold` if Phase 3 and Phase 4 interacted — e.g., if the `utils/money.py` move were required for the `InvoiceTemplate` extraction. They do not; the plan was designed for this.

## Action
Merge. Confirm issues #431 and #432 are open and assigned before the PR is closed.

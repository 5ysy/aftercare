# Good Architecture Review Example

A grounded review of a fictional change that moved invoice generation from a controller into a dedicated service, but left a boundary problem behind. Observe: every finding cites a principle, names a concrete next change, and recommends a narrow repair.

---

# Architecture Review: Invoice Generation Extraction

## Summary
The change extracts invoice generation from `BillingController` into a new `InvoiceService`, which is a real improvement in decision-locality. However, the new service imports the HTTP response type directly, pulling a transport concern into the domain layer. One High finding, two Medium.

## Scope
- **Change under review:** PR #412, branch `feature/invoice-service`
- **Feature traced end-to-end:** monthly invoice generation, from `POST /invoices/generate` to PDF storage in S3
- **Files touched:** 7 files across 3 top-level folders (`api/`, `services/`, `adapters/`)

## Structural map
- **Entry point:** `api/billing_controller.py`
- **Orchestration:** `services/invoice_service.py` (new)
- **Domain logic:** `services/invoice_service.py`, `domain/invoice.py`
- **Infrastructure adapters:** `adapters/pdf_renderer.py`, `adapters/s3_store.py`
- **Tests:** `tests/services/test_invoice_service.py` (covers orchestration); `tests/api/test_billing_controller.py` (thin, still green)

## Findings

### Transport type leaked into service layer
- **Severity:** High
- **Principle violated:** Separate orchestration from logic
- **Anti-pattern match:** Framework-shaped domain (`anti-patterns.md`)
- **Observation:** `services/invoice_service.py:14` imports `FlaskResponse` and returns it from `generate_invoice()`. The controller now forwards the response object directly.
- **Cost:** When invoice generation is invoked from the upcoming scheduled-job runner (planned next sprint per the ticket), the runner will have to construct a fake `FlaskResponse` to call this service.
- **Smallest repair:** `generate_invoice()` returns a domain `InvoiceResult` dataclass; the controller translates it to an HTTP response. ~15 lines changed in two files.

### Orchestration owns PDF rendering details
- **Severity:** Medium
- **Principle violated:** Keep public surfaces small
- **Observation:** `InvoiceService.generate_invoice` passes font sizes and page margins to `pdf_renderer.render()`. These are rendering concerns, not invoice concerns.
- **Cost:** Changing the PDF template requires changes in the service, not just the renderer.
- **Smallest repair:** Move rendering parameters behind a named `InvoiceTemplate` the renderer owns; service passes only the invoice data.

### New `utils/money.py` has one caller
- **Severity:** Medium
- **Principle violated:** Avoid universal shared folders
- **Anti-pattern match:** Speculative shared module (`../dependency-governance/anti-patterns.md`)
- **Observation:** `utils/money.py` is new and imported only by `invoice_service.py`.
- **Cost:** Encourages future unrelated money handling code to accumulate here rather than in its owning feature.
- **Smallest repair:** Move into `services/` alongside the invoice service. Promote later if a second caller appears.

## Why It Matters
The largest risk is the High finding: the service cannot be reused from the scheduled job without reshaping its interface. The next change in this area is already planned, which is why this finding is High rather than Medium.

## Recommended Next Action
Fix the High finding before merge; track the two Medium findings as follow-ups in the same sprint.

## Verdict
merge with follow-up

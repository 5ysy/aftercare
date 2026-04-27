# Staged Refactor Plan — Worked Example

Continuing the invoice-extraction scenario from [`../architecture-review/examples/good-report.md`](../../architecture-review/examples/good-report.md). The architecture review found one High and two Medium findings. This plan addresses them in four phases.

---

# Refactor Plan: Decouple InvoiceService from HTTP transport

## Source findings
- Transport type leaked into service layer (High) — from `architecture-review/examples/good-report.md`
- Orchestration owns PDF rendering details (Medium) — from same report
- New `utils/money.py` has one caller (Medium) — from same report

## Out of scope
- Broader money-type policy across the repo — deferred; revisit when a second caller for money formatting appears.
- Migrating `BillingController` to async — deferred; separate concern not raised by review.

## Goal
`InvoiceService` returns a domain result that can be consumed from both the HTTP controller and the upcoming scheduled-job runner, without any changes to invoice-generation behavior.

## Non-goals
- Changing invoice PDF output.
- Changing the storage layer (S3 bucket, path scheme).
- Restructuring `BillingController` beyond what is needed to translate the new return type.

## Behavior to preserve
- `POST /invoices/generate` returns the same HTTP response shape (status, body, headers) for the same inputs — pinned by `tests/api/test_billing_controller.py::test_generate_invoice_happy_path` and `…::test_generate_invoice_missing_customer`.
- The PDF bytes written to S3 are byte-identical for the same invoice — pinned by hardening Phase 1 below.
- Error handling: invalid input → 400 with the same body shape; downstream failure → 502 with the same body shape — pinned by existing controller tests.

## Constraints
- Preserve external behavior as listed above.
- Each phase lands as a single reviewable PR.
- No phase exceeds ~6 files or ~150 lines of diff.
- No phase mixes cleanup with behavior change.

## Phase 1 — Harden PDF-bytes contract test
- **Responsibility:** Pin the PDF byte output for a canonical invoice fixture so later phases cannot silently change it.
- **Files:**
  - add: `tests/services/test_invoice_pdf_contract.py`
  - add: `tests/fixtures/invoice_canonical.json`
  - add: `tests/fixtures/invoice_canonical.pdf` (committed reference bytes)
- **Verification:** new test passes on current main; intentionally break `pdf_renderer.render` in a scratch branch to confirm the test fails.
- **Depends on:** none
- **Reviewable as:** single PR; no production code changes.

## Phase 2 — Introduce `InvoiceResult` DTO and route controller through it
- **Responsibility:** `InvoiceService.generate_invoice()` returns a new `InvoiceResult` dataclass; `BillingController` translates it to the existing HTTP response. No behavior change.
- **Files:**
  - add: `domain/invoice_result.py`
  - modify: `services/invoice_service.py` — remove `FlaskResponse` import and return type; return `InvoiceResult`.
  - modify: `api/billing_controller.py` — translate `InvoiceResult` into the current HTTP response shape.
  - modify: `tests/services/test_invoice_service.py` — assert on `InvoiceResult`, not on HTTP-shaped return.
- **Verification:** 
  - `tests/api/test_billing_controller.py` passes unchanged.
  - `tests/services/test_invoice_pdf_contract.py` passes unchanged.
- **Depends on:** Phase 1
- **Reviewable as:** single PR; closes the High finding.

## Phase 3 — Move rendering parameters behind `InvoiceTemplate`
- **Responsibility:** Rendering parameters (font sizes, margins) move into a named `InvoiceTemplate` owned by `pdf_renderer`. `InvoiceService` passes invoice data only.
- **Files:**
  - add: `adapters/invoice_template.py`
  - modify: `adapters/pdf_renderer.py` — accept template object, read parameters from it.
  - modify: `services/invoice_service.py` — drop rendering parameters from its surface.
- **Verification:**
  - `tests/services/test_invoice_pdf_contract.py` passes (bytes unchanged).
  - `tests/services/test_invoice_service.py` passes.
- **Depends on:** Phase 2
- **Reviewable as:** single PR; closes the first Medium finding.

## Phase 4 — Relocate `utils/money.py`
- **Responsibility:** Move the single-consumer helper next to its consumer.
- **Files:**
  - move: `utils/money.py` → `services/invoice_money.py`
  - modify: `services/invoice_service.py` import path.
  - delete: `utils/money.py` (the file; the directory may remain if it has other contents).
- **Verification:** all tests pass; `grep -r "utils.money" .` returns no matches.
- **Depends on:** Phase 2
- **Reviewable as:** single PR; closes the second Medium finding.

## Stop points

- **Unexpected PDF byte change after Phase 2 or 3.** Revert the offending phase; re-open as a bug, not a refactor step.
- **Phase 2 diff exceeds ~150 lines.** Pause; the DTO translation is larger than expected — re-scope before continuing.
- **Confidence drop during Phase 3.** Ship phases 1–2 as the improvement; re-plan phases 3–4 later or drop them. The High finding is already closed after Phase 2, so partial completion is a net win.

For each stop point, the safe shipping state is "phases 1 through N are merged; remaining phases become a separate follow-up plan."

## Gap to ideal

After Phase 4, `InvoiceService` is decoupled from HTTP and rendering parameters live behind a template. A fully async pipeline for invoice generation is **still out of scope** and will remain a known gap; revisit when async is adopted elsewhere in the codebase.

## Handoff

Execution is owned by [`../executing-incremental-refactors/SKILL.md`](../../executing-incremental-refactors/SKILL.md). This document is the input.

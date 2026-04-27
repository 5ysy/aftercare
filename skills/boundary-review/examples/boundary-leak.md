# Boundary Leak Example

A worked High-severity boundary leak. The change is small; the leak is structural.

---

## Scenario

The repo has three top-level packages:

- `orders/` — the orders feature (public surface: `orders/__init__.py`)
- `billing/` — the billing feature (public surface: `billing/__init__.py`)
- `shared/` — cross-feature primitives (money types, date utilities, common errors)

Intended boundaries:

- `orders` and `billing` are independent features. They should talk only through their public surfaces, or through events.
- `shared/` knows about neither feature.

## The change

A PR adds a "show the most recent invoice" panel on the order detail page. The author needs invoice data, so they do the convenient thing:

```python
# orders/views/order_detail.py
from billing.repositories.invoice_repo import InvoiceRepository  # reach-through
from billing.domain.invoice import Invoice                        # cross-feature internal

def order_detail(order_id):
    order = load_order(order_id)
    invoice: Invoice = InvoiceRepository().latest_for_order(order_id)
    return render("order_detail.html", order=order, invoice=invoice)
```

And, because `Invoice` has a field that needed a display format, the author adds a helper in `shared/`:

```python
# shared/formatting.py
from billing.domain.invoice import Invoice  # backflow into shared

def format_invoice_total(invoice: Invoice) -> str:
    ...
```

## What the boundary review finds

### Finding 1: Reach-through import into billing internals

- **Severity:** High
- **Principle violated:** Make boundaries visible
- **Anti-pattern:** Reach-through import (`anti-patterns.md`)
- **Observation:** `orders/views/order_detail.py` imports `billing.repositories.invoice_repo.InvoiceRepository` and `billing.domain.invoice.Invoice`. `billing/__init__.py` does not export these.
- **Cost:** A planned change to `billing` — switching the invoice storage backend next quarter — will silently break the orders view. The orders team will discover this at deploy time.
- **Smallest repair:** `billing` exposes a public function `get_latest_invoice_summary_for_order(order_id) -> InvoiceSummary`, returning a small DTO. `orders` imports only that. ~20 lines changed in three files.

### Finding 2: Backflow from `shared/` into `billing/`

- **Severity:** High
- **Principle violated:** Avoid universal shared folders
- **Anti-pattern:** Dependency backflow; Shared-module bridge
- **Observation:** `shared/formatting.py:2` imports `billing.domain.invoice.Invoice`. `shared/` is supposed to know about neither feature.
- **Cost:** The import graph now contains a cycle-shaped hazard: anything in `shared/` is implicitly coupled to `billing/`. Any future primitive added to `shared/` that incidentally imports other features will compound this.
- **Smallest repair:** `format_invoice_total` moves into `billing/formatting.py`. If a truly generic money-formatting primitive is needed, it takes primitives (`Decimal`, `Currency`) not domain objects.

## Why this is High, not Medium

The boundary between `orders` and `billing` is explicit (separate packages, separate `__init__.py` surfaces) and load-bearing (they have separate owners and separate release concerns). The leak is not stylistic — it will directly cost time in the next planned change.

## Why this is not Critical

No correctness issue, no production risk today. The cost is future change cost, not present breakage.

## What the review does **not** say

- It does not demand a new "anti-corruption layer" pattern.
- It does not require `orders` and `billing` to communicate via events instead of function calls.
- It does not propose extracting `shared/` into a separate repo.

These are all legitimate architectural moves, but not the smallest repair. The boundary review names the leak and points at the narrow fix. If the team wants a larger change, that is [`../refactor-planning/SKILL.md`](../../refactor-planning/SKILL.md)'s job.

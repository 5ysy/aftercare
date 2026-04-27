# Fragile Pipeline Example

A worked example of a pipeline where the happy path works cleanly but retry semantics hide a High-severity correctness risk.

---

## Scenario

An async job processes paid orders:

1. `dequeue` — pulls the order from a queue
2. `charge_card` — calls the payment provider to charge the customer
3. `create_shipment` — calls the warehouse API to reserve inventory and create a shipment
4. `notify_customer` — sends the confirmation email
5. `ack` — acknowledges the message

The queue has at-least-once delivery with a 30-second visibility timeout. On any exception in the handler, the message is re-delivered.

## The code (simplified)

```python
def handle_order_message(msg):
    order = decode(msg)
    charge = payment_provider.charge(order.card, order.amount)   # stage 2
    shipment = warehouse.create_shipment(order.items)             # stage 3
    email.send(order.customer, template="order_confirm",          # stage 4
               charge_id=charge.id, shipment_id=shipment.id)
    msg.ack()                                                     # stage 5
```

## What the happy-path review would say

"Clear function, good names, reasonable error propagation, logs at entry and exit. Looks fine."

## What pipeline-review finds

### Finding 1: Retry without idempotency on a write path

- **Severity:** **Critical** (promoted from High by the rubric: retry without idempotency on a customer-impacting write path).
- **Anti-pattern:** Retry-without-idempotency.
- **Observation:** If `warehouse.create_shipment` or `email.send` raises, the message is re-delivered. On retry, `payment_provider.charge` is called again with no idempotency key; the customer is charged twice.
- **Cost:** Real money, customer-visible, duplicate-refund ticket for every transient warehouse failure.
- **Smallest repair:** Pass an idempotency key derived from the order ID to `payment_provider.charge`. Most providers accept this and dedupe server-side. ~3 lines of change.

### Finding 2: Duplicate shipments on retry

- **Severity:** **High**.
- **Anti-pattern:** Retry-without-idempotency (non-payment write).
- **Observation:** If `email.send` raises after `create_shipment` succeeds, the retry will call `create_shipment` again, creating a second shipment.
- **Cost:** Duplicate inventory reservation, duplicate physical shipment, manual reconciliation.
- **Smallest repair:** `warehouse.create_shipment` call keyed on the order ID; on conflict, return the existing shipment.

### Finding 3: Ack is the only completion signal

- **Severity:** **High** (silent retry exhaustion floor for async jobs).
- **Anti-pattern:** Silent giving up.
- **Observation:** If the message fails 10 times and is sent to the DLQ (queue default), no alert fires and no metric exists specifically for DLQ arrivals for this job type.
- **Cost:** Orders quietly stall; customers notice before operators do.
- **Smallest repair:** Metric `orders_dlq_total{job="handle_order"}`, alert at >0 sustained for 5 minutes. (Full observability treatment belongs to [`../observability-review/SKILL.md`](../../observability-review/SKILL.md); this report notes it because the silent-failure risk is pipeline-structural, not a pure visibility gap.)

### Finding 4: Implicit stages

- **Severity:** **Medium** (stage-ambiguity floor for async jobs).
- **Anti-pattern:** Invisible stages.
- **Observation:** The stages exist conceptually in the code review's description above but are not named in the code. When operators ask "where did it fail?", the answer has to be reconstructed from log order.
- **Cost:** Slower incident response; per-stage metrics are impossible without adding structure.
- **Smallest repair:** Factor into named functions (`_charge`, `_create_shipment`, `_notify`) called by a small orchestrator that logs stage boundaries.

## Why this example matters

The code is clean. It reads well. Tests for the happy path pass. Nothing a line-by-line review would flag.

The pipeline-review's value is in asking the three questions (fail → visibility, retry → duplicates, rerun → semantics) and refusing to accept the happy-path frame. Two of the four findings here are merge-blockers under the rubric, and neither is visible without treating the pipeline as an operational system.

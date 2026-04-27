# Observability Review Checklist

For each risky surface introduced or modified by the change, walk through the relevant sections.

## 1. Failure context

- [ ] When an exception is caught, is the original stack preserved (not flattened to a string)?
- [ ] Do error messages include the inputs or identifiers needed to reproduce the failure?
- [ ] Are correlation IDs (request ID, job ID, user ID) propagated into the error path?
- [ ] Can an operator distinguish expected failures from unexpected ones from logs alone?

## 2. Important transitions

- [ ] Are state changes on critical paths visible (started, succeeded, failed, abandoned)?
- [ ] For multi-step flows, can you reconstruct which step failed without attaching a debugger?
- [ ] Are async handoffs (enqueue/dequeue, request/response) logged on both sides?

## 3. Retries and backoffs

- [ ] Does each retry attempt produce a signal, not just the final outcome?
- [ ] Can an operator tell "retried 3 times then succeeded" from "retried 3 times then gave up"?
- [ ] Is the retry count or attempt number in the log/metric?
- [ ] Is there a metric or log for retry exhaustion specifically?

## 4. Metrics

- [ ] Is there at least one metric that distinguishes healthy from unhealthy for this surface?
- [ ] Are latency, error rate, and throughput measured where they matter?
- [ ] Do metrics carry enough labels/tags to debug but not so many to explode cardinality?
- [ ] Is there a metric that would trigger an alert, or just ones that require dashboards to read?

## 5. Tracing

- [ ] Does the change respect existing tracing context (spans propagate across boundaries)?
- [ ] Are newly introduced async boundaries wrapped in spans if the rest of the system is traced?
- [ ] Are span names stable enough to aggregate, specific enough to debug?

## 6. Operator visibility

- [ ] Could an operator answer "is this healthy right now?" without reading the source?
- [ ] Could an operator answer "what just happened to request X?" from artifacts alone?
- [ ] Are there any silent success paths (work completes with no trace)?
- [ ] Are there any silent failure paths (errors swallowed without log or metric)?

## Gap severity

For each gap, record a concrete scenario: *"If [specific failure] happens, the on-call would see [what they would see], and would need to [what they would have to do to debug]."* If that action is "attach a debugger to production" or "ask the author," the finding is High or Critical.

# Anti-Patterns

## Controller-as-service
HTTP/controller layer contains business decisions, policy, or persistence choreography.

## Shared-utils sinkhole
A generic shared folder quietly becomes the largest module in the repo.

## Invisible orchestration
Critical multi-stage flows exist but their contracts, retries, or failure paths are not obvious.

## Dependency backflow
Lower-level modules import higher-level policy or presentation concerns.

## Premature platforming
A small feature is wrapped in abstractions intended for scale that does not exist yet.

## Rewrite reflex
A review finds structural issues and immediately recommends a full rewrite instead of staged repair.

## Test illusion
A repo has many tests, but none protect the structural changes the refactor actually depends on.

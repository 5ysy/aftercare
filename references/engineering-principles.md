# Engineering Principles

## Preserve locality
Code that changes together should be easy to find together.

## Make boundaries visible
If a layer or module boundary matters, it should be obvious in the structure.

## Keep public surfaces small
Large public APIs produce large accidental coupling.

## Prefer boring structure
Use the simplest organization that supports the current scale and rate of change.

## Separate orchestration from logic
Entry points should coordinate.
Application/domain code should decide.
Infrastructure should adapt.

## Avoid universal shared folders
Shared locations should be hard to earn.
Most code should live close to the feature that owns it.

## Refactor for the next change
Do not restructure because something is theoretically cleaner.
Restructure because it makes the likely next changes safer and cheaper.

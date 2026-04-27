# Adoption Guide

## Individual developers

Use Aftercare when:

- the change touched multiple modules
- most of the implementation was AI-generated
- the file tree changed
- a shared module grew new responsibilities
- you are about to merge a high-leverage diff

## Small teams

Start with three required skills:

- `architecture-review`
- `refactor-planning`
- `merge-readiness-review`

Then add scenario-specific skills once the team sees repeated patterns.

## Larger teams

Create a repo-specific policy document that clarifies:

- which severities block merge
- which classes of issues can be deferred
- where follow-up plans should be saved
- what counts as adequate test hardening

## Best way to roll it out

Do not start by making everything mandatory.
Start by making the reports useful enough that people want them.
Mandatory gating works only after the findings are trusted.

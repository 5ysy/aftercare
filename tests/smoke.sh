#!/usr/bin/env bash
# smoke.sh — end-to-end validation for the Aftercare repository.
# Runs the skill/doc validators and exits non-zero on any failure.

set -u

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

echo "== Aftercare smoke test =="
echo "Repo: $REPO_ROOT"
echo

bash scripts/validate-skills.sh
rc=$?

echo
if [ "$rc" -eq 0 ]; then
  echo "Smoke test: OK"
else
  echo "Smoke test: FAILED"
fi

exit "$rc"

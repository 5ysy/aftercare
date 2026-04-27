#!/usr/bin/env bash
# validate-skills.sh — structural validation for the Aftercare skill library.
#
# Checks:
#   1. Every skills/*/SKILL.md has frontmatter `name` matching its directory name.
#   2. Every SKILL.md has a non-empty `description` field.
#   3. Every non-SKILL file inside a skill directory is referenced by relative path
#      from its SKILL.md (no orphan sub-files).
#   4. Every relative markdown link inside each SKILL.md and its sub-files resolves
#      to an existing file.
#   5. Every doc listed in README.md's "Repository layout" block exists under docs/.
#   6. AGENTS.md's skill table contains exactly the set of directories under skills/.
#
# Exit code 0 on pass, 1 on any failure.

set -u

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

fail_count=0
pass_count=0

fail() {
  printf "${RED}FAIL${NC} %s\n" "$1"
  fail_count=$((fail_count + 1))
}

pass() {
  printf "${GREEN}PASS${NC} %s\n" "$1"
  pass_count=$((pass_count + 1))
}

info() {
  printf "${YELLOW}INFO${NC} %s\n" "$1"
}

# --- 1 & 2: frontmatter checks ---

info "Checking skill frontmatter..."
for dir in skills/*/; do
  skill=$(basename "$dir")
  skill_file="$dir/SKILL.md"

  if [ ! -f "$skill_file" ]; then
    fail "$skill: missing SKILL.md"
    continue
  fi

  # Extract frontmatter between first pair of --- lines.
  fm=$(awk '/^---$/{c++; next} c==1{print} c==2{exit}' "$skill_file")
  if [ -z "$fm" ]; then
    fail "$skill: no YAML frontmatter"
    continue
  fi

  name=$(printf "%s\n" "$fm" | awk -F': *' '/^name:/ {print $2; exit}' | tr -d '"'"'"'')
  desc=$(printf "%s\n" "$fm" | awk -F': *' '/^description:/ {$1=""; sub(/^ /, ""); print; exit}')

  if [ "$name" != "$skill" ]; then
    fail "$skill: frontmatter name='$name' does not match directory name"
  else
    pass "$skill: frontmatter name matches directory"
  fi

  if [ -z "$desc" ]; then
    fail "$skill: frontmatter description is empty"
  else
    pass "$skill: frontmatter description present"
  fi
done

# --- 3: sub-file reference check ---

info "Checking sub-file references..."
for dir in skills/*/; do
  skill=$(basename "$dir")
  skill_file="$dir/SKILL.md"
  [ -f "$skill_file" ] || continue

  # Find all non-SKILL files (skip examples/ directory listing as a whole dir is fine)
  while IFS= read -r subfile; do
    rel="${subfile#$dir}"
    # examples/ dir: just check the dir is referenced; individual files are linked from examples too.
    if grep -qF "$rel" "$skill_file"; then
      pass "$skill: references $rel"
    else
      # Maybe the parent examples/ dir is referenced (acceptable for files inside examples/).
      parent_dir=$(dirname "$rel")
      if [ "$parent_dir" != "." ] && grep -qF "$parent_dir/" "$skill_file"; then
        pass "$skill: references parent dir of $rel"
      else
        fail "$skill: orphan sub-file $rel (not referenced from SKILL.md)"
      fi
    fi
  done < <(find "$dir" -mindepth 1 -type f -not -name "SKILL.md")
done

# --- 4: relative link resolution inside skill markdown files ---

info "Checking relative links inside skill files..."
check_links_in_file() {
  local file="$1"
  local base_dir
  base_dir=$(dirname "$file")

  # Strip fenced code blocks (``` ... ```) before extracting links, so illustrative
  # paths inside examples do not trigger false positives.
  local stripped
  stripped=$(awk '
    /^```/ {in_block = !in_block; next}
    !in_block {print}
  ' "$file")

  # Extract markdown links [text](path) where path is not http/https/mailto and not an anchor.
  while IFS= read -r link; do
    # Strip trailing anchor fragment.
    clean="${link%%#*}"
    [ -z "$clean" ] && continue

    local resolved
    if [ "${clean:0:1}" = "/" ]; then
      resolved="$REPO_ROOT$clean"
    else
      resolved="$base_dir/$clean"
    fi

    if [ ! -e "$resolved" ]; then
      fail "broken link in $file -> $link"
    fi
  done < <(printf "%s\n" "$stripped" \
    | grep -oE '\]\([^)]+\)' \
    | sed -E 's/^\]\(//; s/\)$//' \
    | grep -vE '^(https?:|mailto:|#)' || true)
}

for f in $(find skills -name "*.md" -type f); do
  check_links_in_file "$f"
done
pass "relative link check completed"

# --- 5: README layout references ---

info "Checking docs referenced by README.md..."
if [ -f README.md ]; then
  # Walk the Repository-layout tree. Track which top-level directory we're inside
  # and only verify *.md filenames listed under docs/.
  docs_in_readme=$(awk '
    /^```text$/ {in_block=1; next}
    /^```$/ {in_block=0; current=""; next}
    !in_block {next}
    /── [a-zA-Z_.-]+\// {
      # Top-level directory line like "├── docs/"
      # Extract the directory name.
      line=$0
      sub(/.*── /, "", line)
      sub(/\/.*$/, "", line)
      current=line
      next
    }
    current == "docs" {
      # Extract any *.md filename on this line.
      if (match($0, /[A-Za-z._-]+\.md/)) {
        print substr($0, RSTART, RLENGTH)
      }
    }
  ' README.md | sort -u)

  for md in $docs_in_readme; do
    if [ -f "docs/$md" ]; then
      pass "README layout: docs/$md exists"
    else
      fail "README layout references missing docs/$md"
    fi
  done
fi

# --- 6: AGENTS.md skill table sync ---

info "Checking AGENTS.md skill table vs skills/..."
if [ -f AGENTS.md ]; then
  agents_skills=$(grep -oE '`[a-z-]+`' AGENTS.md \
    | tr -d '`' \
    | sort -u)
  dir_skills=$(ls -1 skills/ | sort -u)

  for s in $dir_skills; do
    if printf "%s\n" "$agents_skills" | grep -qx "$s"; then
      pass "AGENTS.md lists $s"
    else
      fail "AGENTS.md missing skill: $s"
    fi
  done
else
  fail "AGENTS.md not found at repo root"
fi

# --- summary ---

echo
printf "Validation summary: ${GREEN}%d passed${NC}, ${RED}%d failed${NC}\n" "$pass_count" "$fail_count"

if [ "$fail_count" -gt 0 ]; then
  exit 1
fi
exit 0

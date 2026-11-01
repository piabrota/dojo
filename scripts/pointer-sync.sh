#!/usr/bin/env bash
# Move each submodule to the tip of its branch, and keep one rolling branch and pull request for it.
# A person merges the pull request. Run by pointer-sync.yml; --dry-run prints what moved and pushes nothing.
#   pointer-sync.sh [--dry-run]
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
BRANCH=chore/pointer-sync
dry=false
if [ "${1:-}" = --dry-run ]; then dry=true; fi

git submodule update --init --remote --depth 1 --jobs 4
if git diff --quiet; then echo "pointer-sync: every pointer is current"; exit 0; fi
git diff --submodule=short --stat
if $dry; then echo "pointer-sync: dry run, nothing pushed"; exit 0; fi

git switch -C "$BRANCH"
git add -u
git commit -q -m "Move the submodule pointers"
git push --force origin "$BRANCH"
if [ -n "$(gh pr list --head "$BRANCH" --state open --json number --jq '.[].number')" ]; then
  echo "pointer-sync: the open pull request has the new pointers"
elif ! gh pr create --head "$BRANCH" --title "Move the submodule pointers" \
  --body "The submodules' pointers, at the tip of each branch. A person merges this."; then
  # The repo's Actions setting may forbid this; the branch is pushed either way.
  echo "pointer-sync: could not open the pull request; open it from $BRANCH by hand" >&2
fi

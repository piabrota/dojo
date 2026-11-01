#!/usr/bin/env bash
# Fail when REPOS.md's table and .gitmodules name different repos, or a row's upstream differs from the URL.
#   repos-check.sh
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
modules="$(git config -f .gitmodules --get-regexp '\.path$' | cut -d' ' -f2 | LC_ALL=C sort)"
# shellcheck disable=SC2016  # literal backticks: the table's Markdown, not a command
rows="$(sed -n 's/^| `\([^`]*\)` | .*/\1/p' REPOS.md | LC_ALL=C sort)"
if ! diff <(printf '%s\n' "$modules") <(printf '%s\n' "$rows"); then
  echo "repos-check: REPOS.md and .gitmodules name different repos (< .gitmodules, > REPOS.md)" >&2
  exit 1
fi
while IFS= read -r m; do
  url="$(git config -f .gitmodules "submodule.$m.url")"
  grep -qF "](${url%.git})" REPOS.md || { echo "repos-check: REPOS.md has no link to $url" >&2; exit 1; }
done <<<"$modules"
echo "repos-check: $(wc -l <<<"$modules" | tr -d ' ') repos agree"

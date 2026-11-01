#!/usr/bin/env bash
# Write README.md's readiness table: one row per repository of the org, public forks left out. Every value comes
# from GitHub, never by hand. Run it again to refresh; it needs gh, jq and git. The README says what each column means.
#   readiness.sh [--print]    write the table between the README's markers, or only print it
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."
ORG=piabrota
KEEP_OUT='^(vendor|forks|node_modules)/|/node_modules/'
yes_no() { if [ "$1" = 0 ]; then printf '✓'; else printf -- '–'; fi; }
has() { if grep -Eiq -- "$1" <<<"$2"; then printf 0; else printf 1; fi; }
last_page() { # last_page PATH: the number of items behind a list that gives one item per page
  local head
  head="$(gh api -i "$1" --method GET -f per_page=1 2>/dev/null | sed -n '1,/^\r*$/p')"
  if grep -qi '^link:.*rel="last"' <<<"$head"; then
    grep -i '^link:' <<<"$head" | sed -E 's/.*[?&]page=([0-9]+)[^>]*>; rel="last".*/\1/'
  else
    gh api "$1" --method GET -f per_page=1 --jq length
  fi
}
row() {
  local r="$1" repo branch files keep created now age commits people issues site paper loop logo doi mcp a2a wiki text flows f
  repo="$(gh api "repos/$ORG/$r")"
  branch="$(jq -r .default_branch <<<"$repo")"
  files="$(gh api "repos/$ORG/$r/git/trees/$branch?recursive=1" --jq '.tree[].path')"
  keep="$(grep -Ev "$KEEP_OUT" <<<"$files" || true)"
  created="$(jq -r .created_at <<<"$repo" | cut -c1-10)"
  now="$(date -u +%Y-%m-%d)"
  age="$(python3 -I -c 'import sys,datetime as d; print((d.date.fromisoformat(sys.argv[1])-d.date.fromisoformat(sys.argv[2])).days)' "$now" "$created")"
  commits="$(last_page "repos/$ORG/$r/commits")"
  people="$(gh api "repos/$ORG/$r/contributors" --method GET -f per_page=100 -f anon=true --jq length)"
  # shellcheck disable=SC2016  # GraphQL variables, not shell ones
  issues="$(gh api graphql -f query='query($o:String!,$n:String!){repository(owner:$o,name:$n){issues(states:OPEN){totalCount}}}' \
    -f o="$ORG" -f n="$r" --jq .data.repository.issues.totalCount)"
  site=1
  if [ -n "$(jq -r '.homepage // ""' <<<"$repo")" ] || [ "$(jq -r .has_pages <<<"$repo")" = true ]; then site=0; fi
  paper="$(has '(^|/)(papers?|whitepaper)(/|$)|(^|/)whitepaper[^/]*\.(pdf|md|tex)$' "$keep")"
  logo="$(has '(^|/)(logo|favicon|icon)[^/]*\.(svg|png|ico)$|^(docs/)?drawings/[^/]+\.svg$' "$keep")"
  mcp="$(has '^\.mcp\.json$|(^|/)[^/]*mcp[^/]*/' "$keep")"
  a2a="$(has '\.well-known/agent|(^|/)a2a([-_./]|$)|agent-card' "$keep")"
  text="$(gh api "repos/$ORG/$r/readme" --jq .content 2>/dev/null | base64 -d 2>/dev/null || true)"
  if grep -qx 'CITATION.cff' <<<"$files"; then
    text+="$(gh api "repos/$ORG/$r/contents/CITATION.cff" --jq .content | base64 -d)"
  fi
  doi="$(has '\b10\.[0-9]{4,9}/[^ )"]+' "$text")"
  loop=1
  flows="$(grep -E '^\.github/workflows/[^/]+\.ya?ml$' <<<"$files" || true)"
  while IFS= read -r f; do
    [ -n "$f" ] || continue
    if gh api "repos/$ORG/$r/contents/$f" --jq .content | base64 -d | grep -Eiq 'CLAUDE_CODE_OAUTH|anthropics/claude-code'; then loop=0; break; fi
  done <<<"$flows"
  wiki=1
  if GIT_TERMINAL_PROMPT=0 git ls-remote "https://github.com/$ORG/$r.wiki.git" HEAD 2>/dev/null | grep -q .; then wiki=0; fi
  # shellcheck disable=SC2016  # literal backticks: the table's Markdown, not a command
  printf '| [`%s`](https://github.com/%s/%s) | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s | %s |\n' \
    "$r" "$ORG" "$r" "$commits" "$age" "$people" "$(jq -r .stargazers_count <<<"$repo")" "$(jq -r .forks_count <<<"$repo")" \
    "$(yes_no "$site")" "$(yes_no "$paper")" "$(yes_no "$loop")" "$(yes_no "$logo")" "$(yes_no "$doi")" \
    "$(yes_no "$mcp")" "$(yes_no "$a2a")" "$(yes_no "$wiki")" "$issues"
}
table() {
  echo '| Repo | Commits | Age (days) | Contributors | Stars | Forks | Site | Paper | Loop | Logo | DOI | MCP | A2A | Wiki | Open issues |'
  echo '| --- | ---: | ---: | ---: | ---: | ---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | ---: |'
  local r
  for r in $(gh repo list "$ORG" --limit 200 --source --json name --jq '.[].name' | LC_ALL=C sort); do row "$r"; done
}
out="$(table)"
if [ "${1:-}" = --print ]; then printf '%s\n' "$out"; exit 0; fi
OUT="$out" python3 -I - <<'PY'
import os, re
s = open("README.md").read()
new = "<!-- readiness:start -->\n" + os.environ["OUT"] + "\n<!-- readiness:end -->"
s, n = re.subn(r"<!-- readiness:start -->.*<!-- readiness:end -->", lambda _: new, s, flags=re.S)
assert n == 1, "README.md has no readiness markers"
open("README.md", "w").write(s)
PY

# AGENTS.md: dojo

dojo is the piabrota umbrella. It holds every product as a submodule, the routing table and its own
tooling. It holds no product code. Read this before you change anything here.

## Invariants

These rules come from [mu](https://github.com/piabrota/mu): the
[dogma](https://github.com/piabrota/mu/blob/main/DOGMA.md) and the
[invariants](https://github.com/piabrota/mu/blob/main/AGENTS.md#invariants). A child `AGENTS.md` may add
rules; it must not loosen these. This file adds the rules below.

## Where a change belongs

- **One product:** work in that repo, under its `AGENTS.md`, with its own checks. Never here.
- **How the company works:** the dogma, the standards and the decisions belong in mu.
- **The list of products:** here. Add the submodule and its row in `REPOS.md` in one pull request.
- **Across repos:** the same branch name in each repo, one pull request per repo, each linked to the
  others. The producer merges first, and the consumers bump their pins after. dojo's pointers move last.

No repo reads another repo's tree, in CI or in tests.

## Submodule mechanics

- A submodule sits on a detached HEAD at its pinned commit. To work in one, run
  `git switch -c <branch> origin/main` inside it, and open the pull request against that repo.
- **Pointers move only through the sync pull request.** `pointer-sync.yml` moves each submodule to the
  tip of its branch and keeps one rolling branch, `chore/pointer-sync`. Never commit a pointer by hand,
  and never commit inside a submodule from dojo's own branch.
- A person merges the sync pull request.
- **`chaceon` is the exception.** It is private, so `.gitmodules` sets `update = none`: `just init` and the
  sync skip it, and CI never needs access to it. A person moves its pointer by hand, in a pull request.
- Never clone recursively: `just init` is the way in. mu also pins dojo, in its `products/`.

## Commands

| Need | Command |
| --- | --- |
| Check out every repo at its pinned commit | `just init` |
| See what each submodule is on | `just status` |
| Check out `chaceon`, with access to it | `just init-private` |
| Refresh the readiness table in the README | `just readiness` |
| Check that `REPOS.md` and `.gitmodules` agree | `just check` |
| See which pointers are behind, and change nothing outside the checkout | `just sync-dry-run` |

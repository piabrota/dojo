<!-- markdownlint-disable MD033 -->
<div align="center">

<img alt="The piabrota logo: an open green eye on red" src="https://raw.githubusercontent.com/piabrota/mu/e5df894581846f64abafbec8e177044eccea6dd2/docs/drawings/eye.svg" width="160"/>

# dojo

<sub>道場 · the piabrota umbrella · <a href="#in-one-minute">in one minute</a> · <a href="REPOS.md">repos</a> · <a href="AGENTS.md">agents</a> · <a href="#licence">licence</a></sub>

</div>

dojo is the piabrota twin of [ouroboric-dev/yggdrasil](https://github.com/ouroboric-dev/yggdrasil): a hard
fork in role, the same kind of umbrella, for piabrota's own products.
dojo started empty, shares no commits with Yggdrasil, and does not follow upstream.

> [!WARNING]
> dojo is not an Ouroboric project, and Ouroboric does not endorse it. Ouroboric is a partner of piabrota. Report
> a problem with dojo here, not upstream. [NOTICE.md](NOTICE.md) keeps the credit.

## In one minute

- **dojo is the umbrella of [piabrota](https://github.com/piabrota).** Every product is a git submodule
  here, at a pinned commit, so one checkout holds the whole fabric.
- **It holds no product code.** Its only code is its own tooling, in `scripts/`.
- **[mu](https://github.com/piabrota/mu) holds the rules.** The dogma, the charter and the standards live
  there, and dojo inherits them.
- **[REPOS.md](REPOS.md) is the routing table:** which repo owns what.

## Get it

```bash
git clone https://github.com/piabrota/dojo && cd dojo
just init     # every public repo at its pinned commit, shallow
just status   # what each submodule is on
just check    # REPOS.md and .gitmodules agree
```

`chaceon` is private, and `just init` skips it. If you have access, run `just init-private`.

Don't use `git clone --recurse-submodules`. mu pins dojo in its own `products/`, and several products
have submodules of their own, so a recursive clone fetches the same repos many times.

## Readiness

Every repository of the org, public forks left out. `just readiness` writes this table from GitHub, so
each value can be checked and nothing is typed by hand.

<!-- readiness:start -->
| Repo | Commits | Age (days) | Contributors | Stars | Forks | Site | Paper | Loop | Logo | DOI | MCP | A2A | Wiki | Open issues |
| --- | ---: | ---: | ---: | ---: | ---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | :---: | ---: |
| [`.github`](https://github.com/piabrota/.github) | 19 | 3 | 2 | 1 | 0 | – | – | – | – | – | – | – | – | 0 |
| [`agents`](https://github.com/piabrota/agents) | 11 | 1 | 1 | 1 | 0 | – | – | – | – | – | – | – | – | 0 |
| [`alerts`](https://github.com/piabrota/alerts) | 47 | 10 | 1 | 1 | 0 | – | – | – | ✓ | – | ✓ | – | – | 7 |
| [`dojo`](https://github.com/piabrota/dojo) | 6 | 0 | 1 | 1 | 0 | – | – | – | – | – | – | – | – | 0 |
| [`gramatico`](https://github.com/piabrota/gramatico) | 142 | 12 | 2 | 6 | 1 | ✓ | ✓ | – | ✓ | ✓ | ✓ | – | – | 17 |
| [`ihero`](https://github.com/piabrota/ihero) | 1 | 0 | 1 | 1 | 0 | – | – | – | – | – | – | – | – | 0 |
| [`mu`](https://github.com/piabrota/mu) | 107 | 6 | 3 | 1 | 0 | – | – | – | ✓ | – | – | – | – | 0 |
| [`nix-os`](https://github.com/piabrota/nix-os) | 63 | 3 | 4 | 2 | 1 | ✓ | – | ✓ | ✓ | – | ✓ | – | ✓ | 5 |
| [`pirsig`](https://github.com/piabrota/pirsig) | 66 | 10 | 3 | 3 | 1 | – | – | – | ✓ | – | ✓ | – | – | 0 |
| [`rax`](https://github.com/piabrota/rax) | 29 | 4 | 2 | 1 | 1 | – | – | – | ✓ | – | – | – | – | 0 |
<!-- readiness:end -->

- **Commits, Contributors, Stars, Forks:** GitHub's counts for the default branch and the repository.
  Contributors include bots.
- **Age:** days since the repository was created.
- **Site:** a homepage or GitHub Pages is set on the repository.
- **Paper:** a `paper/`, `papers/` or `whitepaper/` folder, or a whitepaper file.
- **Loop:** a workflow runs an agent on the repository by itself.
- **Logo:** a logo, favicon or icon file, or a drawing in `drawings/` or `docs/drawings/`.
- **DOI:** a DOI in the README or in `CITATION.cff`.
- **MCP:** an `.mcp.json` at the root, or a folder with `mcp` in its name.
- **A2A:** an agent card, or a folder or file named `a2a`.
- **Wiki:** the repository's wiki exists, not only the setting.
- **Open issues:** open issues, without pull requests.

`vendor/`, `forks/` and `node_modules/` don't count as evidence.

## Licence

This repository is under the [Mozilla Public License 2.0](LICENSE). Each submodule has its own licence,
named in [REPOS.md](REPOS.md). The piabrota name and logo are the org's marks, and are not under that
licence.

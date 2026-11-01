<!-- markdownlint-disable MD033 -->
<div align="center">

<img alt="The piabrota logo: an open green eye on red" src="https://raw.githubusercontent.com/piabrota/mu/e5df894581846f64abafbec8e177044eccea6dd2/docs/drawings/eye.svg" width="160"/>

# dojo

<sub>道場 · the piabrota umbrella · <a href="#in-one-minute">in one minute</a> · <a href="REPOS.md">repos</a> · <a href="AGENTS.md">agents</a> · <a href="#licence">licence</a></sub>

</div>

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
just init     # every repo at its pinned commit, shallow
just status   # what each submodule is on
just check    # REPOS.md and .gitmodules agree
```

Don't use `git clone --recurse-submodules`. mu pins dojo in its own `products/`, and several products
have submodules of their own, so a recursive clone fetches the same repos many times.

## Licence

This repository is under the [Mozilla Public License 2.0](LICENSE). Each submodule has its own licence,
named in [REPOS.md](REPOS.md). The piabrota name and logo are the org's marks, and are not under that
licence.

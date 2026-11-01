# Repos

The routing table: every submodule of dojo, and what it owns. `scripts/repos-check.sh` fails when this
table and `.gitmodules` disagree. Each repo's own `AGENTS.md` and README hold the rest.

| Repo | Upstream | Stack | Licence | Owns |
| --- | --- | --- | --- | --- |
| `mu` | [piabrota/mu](https://github.com/piabrota/mu) | Markdown, Bash | CC BY 4.0, AGPL-3.0, MPL-2.0 | the company chart: dogma, charter, standards, repo index, the brain |
| `pirsig` | [piabrota/pirsig](https://github.com/piabrota/pirsig) | Rust | MPL-2.0 | the second brain: PARA, the slip-box, the `psg` CLI |
| `gramatico` | [piabrota/gramatico](https://github.com/piabrota/gramatico) | Rust | MPL-2.0 | technical writing in Brazilian Portuguese, as a Claude Code plugin |
| `alerts` | [piabrota/alerts](https://github.com/piabrota/alerts) | Rust | MPL-2.0 | the alert platform, from official sources only |
| `rax` | [piabrota/rax](https://github.com/piabrota/rax) | Rust | MPL-2.0, parts Apache-2.0 | the agentic runtime on Kubernetes |
| `agents` | [piabrota/agents](https://github.com/piabrota/agents) | Bash | MPL-2.0 | the agents that watch nix-os and its VPS |
| `nix-os` | [piabrota/nix-os](https://github.com/piabrota/nix-os) | Nix | MPL-2.0 | the VPS that serves piabrota.art; a merge to its `main` is a deploy |
| `ihero` | [piabrota/ihero](https://github.com/piabrota/ihero) | none yet | MPL-2.0 | a music player and game; only its licence so far |
| `chaceon` | [h0ffmann/chaceon](https://github.com/h0ffmann/chaceon) (private) | Rust | closed source, for now | the Rust port of WW3, the wave physics model; only people with access can fetch it |
| `skills` | [h0ffmann/skills](https://github.com/h0ffmann/skills) | Markdown, Gleam | MPL-2.0 | the agent skills |
| `astrbot_dw_ext_br_south_disaster` | [h0ffmann/astrbot_dw_ext_br_south_disaster](https://github.com/h0ffmann/astrbot_dw_ext_br_south_disaster) | Python | MPL-2.0 | the AstrBot extension for disasters in the South of Brazil |
| `astrbot_dw_ext_br_south_waterq` | [h0ffmann/astrbot_dw_ext_br_south_waterq](https://github.com/h0ffmann/astrbot_dw_ext_br_south_waterq) | Python | MPL-2.0 | the AstrBot extension for bathing water quality in the South of Brazil |

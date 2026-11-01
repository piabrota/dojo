# The umbrella's recipes. Each repo keeps its own in its own justfile.

# List the recipes
default:
    @just --list

# Check out every repo at its pinned commit, shallow and not recursive
init:
    git submodule update --init --depth 1 --jobs 4

# Show what each submodule is on
status:
    git submodule status

# Check that REPOS.md and .gitmodules agree
check:
    scripts/repos-check.sh

# Show which pointers are behind; this moves them in the checkout, and pushes nothing
sync-dry-run:
    scripts/pointer-sync.sh --dry-run

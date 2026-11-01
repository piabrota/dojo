# The umbrella's recipes. Each repo keeps its own in its own justfile.

# List the recipes
default:
    @just --list

# Check out every repo at its pinned commit, shallow and not recursive
init:
    git submodule update --init --depth 1 --jobs 4

# Check out chaceon, which is private and which init skips; needs access to it
init-private:
    git submodule update --init --checkout --depth 1 chaceon

# Show what each submodule is on
status:
    git submodule status

# Check that REPOS.md and .gitmodules agree
check:
    scripts/repos-check.sh

# Write README.md's readiness table from GitHub
readiness:
    scripts/readiness.sh

# Show which pointers are behind; this moves them in the checkout, and pushes nothing
sync-dry-run:
    scripts/pointer-sync.sh --dry-run

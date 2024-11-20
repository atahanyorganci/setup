update:
    # Fail if there are uncommitted changes
    git diff --exit-code
    nix flake update
    git add flake.lock
    git commit -m "chore: update flake.lock"

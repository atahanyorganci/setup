update:
    git stash save
    nix flake update
    git add flake.lock
    git commit -m "chore: update flake.lock"
    git stash pop

is-clean:
    @git diff --exit-code --quiet || (echo "Uncommitted changes in repository" && exit 1)

update *args: is-clean
    nix flake update {{args}}
    git add flake.lock
    git commit -m "chore: update flake.lock"

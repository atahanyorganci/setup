#!/bin/env fish

function die -d "Exit with error message"
    echo $argv
    exit 1
end

if test (count $argv) -ne 1
    echo "Usage: config.fish DEST"
    exit 1
end

set -l dest $argv[1]
set -l dir (mktemp -d -t "dotfiles-XXXXXXXXXX")

git clone https://github.com/atahanyorganci/dotfiles.git $dir || die "Failed to clone dotfiles"
mkdir -p $dest && mv "$dir/.git" $dest && rm -rf $dir
git --git-dir=$dest/.git --work-tree=$dest checkout -f || die "Failed to checkout dotfiles"

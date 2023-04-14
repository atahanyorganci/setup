#!/usr/bin/env fish

function fish_title --description "Set terminal title"
    if set -q argv[1]
        set -l arg $argv[1]
        echo "[$arg] @ "
    end
    set -l escaped (string replace -a "/" "\/" $HOME)
    if string match -rq "$escaped(?<path>.*)" $PWD
        echo "~$path"
    else
        echo $PWD
    end
end

function c --description "Visiual Studio Code" --wraps code
    if test (count $argv) -gt 0
        command code $argv
    else
        command code .
    end
end

set -Ux OS (os)
set -Ux EDITOR code

# XDG Base Directory Specification
set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux XDG_DATA_HOME $HOME/.local/share
set -Ux XDG_CACHE_HOME $HOME/.cache
set -Ux XDG_STATE_HOME $HOME/.local/state

# OS dependent configurations
switch $OS
    case Darwin
        # Initialize Homebrew
        /opt/homebrew/bin/brew shellenv | source
    case WSL
        # Add WIN_ROOT and WIN_HOME to WSL environment
        set -Ux WIN_ROOT /mnt/c
        set -Ux WIN_HOME /mnt/c/Users/Atahan
        fish_add_path "$WIN_ROOT/Program Files/Microsoft VS Code/bin"
end

# Configure CARGO_HOME, RUSTUP_HOME and add cargo binaries to PATH
set -Ux CARGO_HOME $XDG_DATA_HOME/cargo
set -Ux RUSTUP_HOME $XDG_DATA_HOME/rustup
fish_add_path $CARGO_HOME/bin

# Set fish prompt and greeting
eval (starship init fish)
set fish_greeting

# Created by `pipx`
fish_add_path $HOME/.local/bin

# Add `SCRIPTLY_ROOT` variable for `scriptly`
set -Ux SCRIPTLY_ROOT $HOME/Development/tools

# Optout of the .NET telementry
set -Ux DOTNET_CLI_TELEMETRY_OPTOUT 1

# Configure `fzf.fish` keybindings
fzf_configure_bindings
fzf_configure_bindings --git_log=\cg

# Set GOPATH
set -Ux GOPATH $XDG_DATA_HOME/go
fish_add_path $GOPATH/bin

# Move `.node_repl_history` to `XDG_STATE_HOME`
set -Ux NODE_REPL_HISTORY $XDG_STATE_HOME/node_repl_history

# Execute startup script to change .python_history's location
set -Ux PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py
set -Ux PYTHONHISTFILE $XDG_STATE_HOME/python/history

# Configure kitty
set -l KITTY_CONFIG_DIRECTORY $XDG_CONFIG_HOME/kitty
set -l KITTY_CACHE_DIRECTORY $XDG_CACHE_HOME/kitty

# User data dir for pandoc contains templates
set -Ux PANDOC_DATA_DIR (pandoc -v | grep data | awk -F: '{ gsub(/ /,""); print $2; }')

# Volta Node.js Version Manager
set -Ux VOLTA_HOME "$XDG_DATA_HOME/volta"
fish_add_path "$VOLTA_HOME/bin" $PATH

# Fly.io CLI
set -Ux FLY_INSTALL "$XDG_DATA_HOME/fly"
fish_add_path "$FLY_INSTALL/bin" $PATH

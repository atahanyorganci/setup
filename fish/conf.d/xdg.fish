#!/usr/bin/env fish

set -Ux EDITOR code
set -Ux DEV_HOME $HOME/Documents

# XDG Base Directory Specification
set -Ux XDG_CONFIG_HOME $HOME/.config
set -Ux XDG_DATA_HOME $HOME/.local/share
set -Ux XDG_CACHE_HOME $HOME/.cache
set -Ux XDG_STATE_HOME $HOME/.local/state

# Add .local/bin to `PATH`
mkdir -p "$HOME/.local/bin"
fish_add_path "$HOME/.local/bin"

# Export `CARGO_HOME` and `RUSTUP_HOME`
set -Ux CARGO_HOME $XDG_DATA_HOME/cargo
set -Ux RUSTUP_HOME $XDG_DATA_HOME/rustup
fish_add_path "$CARGO_HOME/bin"

# Optout of the .NET telementry
set -Ux DOTNET_CLI_TELEMETRY_OPTOUT 1

# Move `.node_repl_history` to `XDG_STATE_HOME`
set -Ux NODE_REPL_HISTORY $XDG_STATE_HOME/node_repl_history

# Execute startup script to change .python_history's location
set -Ux PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup.py
set -Ux PYTHONHISTFILE $XDG_STATE_HOME/python/history

# Configure kitty
set -l KITTY_CONFIG_DIRECTORY $XDG_CONFIG_HOME/kitty
set -l KITTY_CACHE_DIRECTORY $XDG_CACHE_HOME/kitty

# Fly.io CLI
set -Ux FLY_INSTALL "$XDG_DATA_HOME/fly"
fish_add_path "$FLY_INSTALL/bin" $PATH

set -Ux DOCKER_CONFIG_HOME "$XDG_CONFIG_HOME/docker"
set -Ux WGETRC "$XDG_CONFIG_HOME/wgetrc"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

#!/usr/bin/env fish

set -Ux DEV_HOME $HOME/Documents

# Optout of the .NET telementry
set -Ux DOTNET_CLI_TELEMETRY_OPTOUT 1

# Move `.node_repl_history` to `XDG_STATE_HOME`
set -Ux NODE_REPL_HISTORY $XDG_STATE_HOME/node_repl_history

set -Ux DOCKER_CONFIG_HOME "$XDG_CONFIG_HOME/docker"

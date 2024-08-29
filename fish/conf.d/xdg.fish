#!/usr/bin/env fish

set -Ux DEV_HOME $HOME/Documents

# Optout of the .NET telementry
set -Ux DOTNET_CLI_TELEMETRY_OPTOUT 1

set -Ux DOCKER_CONFIG_HOME "$XDG_CONFIG_HOME/docker"

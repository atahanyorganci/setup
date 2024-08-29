#!/usr/bin/env fish

# Optout of the .NET telementry
set -Ux DOTNET_CLI_TELEMETRY_OPTOUT 1

set -Ux DOCKER_CONFIG_HOME "$XDG_CONFIG_HOME/docker"

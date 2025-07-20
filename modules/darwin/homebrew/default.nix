{ lib, config, ... }:
let
  casks = config.homebrew.casks;
  enabled = builtins.length casks > 0;
in
{
  config = {
    homebrew = lib.mkIf enabled {
      enable = true;
      caskArgs.no_quarantine = true;
    };
  };
}

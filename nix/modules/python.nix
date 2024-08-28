{
  pkgs,
  lib,
  config,
  ...
}:
let
  versions = {
    "3.9" = pkgs.python39;
    "3.10" = pkgs.python310;
    "3.11" = pkgs.python311;
    "3.12" = pkgs.python312;
  };
  availableVersions = builtins.attrNames versions;
  sortedVersions = builtins.sort (a: b: (builtins.compareVersions a b) < 0) availableVersions;
  latestVersion = builtins.elemAt sortedVersions (builtins.length sortedVersions - 1);
  python = versions.${config.python.version};
in
{
  options.python = {
    version = lib.mkOption {
      type = lib.types.enum sortedVersions;
      default = latestVersion;
      description = "The version of Python to install.";
    };
  };
  config = {
    home.packages = with pkgs; [
      python
    ];
  };
}

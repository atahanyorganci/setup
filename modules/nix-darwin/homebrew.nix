{ lib, config, ... }:
let
  cfg = config.homebrew;
  casks = builtins.filter (key: cfg.apps.${key}) (builtins.attrNames cfg.apps);
  enabled = (builtins.length casks) > 0;
  mkCaskOption =
    name: enabled:
    lib.mkOption {
      type = lib.types.bool;
      default = enabled;
      description = "Install ${name} cask via Homebrew.";
    };
in
{
  options.homebrew = {
    apps = {
      google-chrome = mkCaskOption "Google Chrome" true;
      orbstack = mkCaskOption "Orbstack" true;
      raycast = mkCaskOption "Raycast" true;
      slack = mkCaskOption "Slack" true;
      spotify = mkCaskOption "Spotify" true;
      visual-studio-code = mkCaskOption "Visual Studio Code" true;
      whatsapp = mkCaskOption "WhatsApp" true;
    };
  };
  config = {
    homebrew = {
      enable = enabled;
      casks = casks;
      caskArgs.no_quarantine = true;
    };
  };
}

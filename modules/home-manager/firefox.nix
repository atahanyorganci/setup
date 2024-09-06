{ pkgs, lib, config, user, ... }:
{
  options.firefox.enable = lib.mkEnableOption "Firefox";
  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-bin;
    };
  };
}

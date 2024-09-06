{ pkgs, lib, config, user, ... }:
{
  options.firefox.enable = lib.mkEnableOption "Firefox";
  config = lib.mkIf config.firefox.enable {
    # This is patch for Firefox to allow downgrading to profiles.ini.
    #
    # Usefull links
    # - https://github.com/bandithedoge/nixpkgs-firefox-darwin/issues/14
    # - https://github.com/nix-community/home-manager/issues/5717
    # - https://github.com/nix-community/home-manager/pull/5801
    # - https://github.com/nix-community/home-manager/pull/5723
    home.sessionVariables = {
      MOZ_LEGACY_PROFILES = 1;
      MOZ_ALLOW_DOWNGRADE = 1;
    };
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-bin;
      profiles.${user.username} = {
        name = user.name;
        isDefault = true;
      };
    };
  };
}

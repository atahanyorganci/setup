{ pkgs, user, ... }:
{
  imports = [
    ../../modules/home-manager
  ];
  git = {
    enable = true;
    aliases.enable = true;
    user = {
      inherit (user) name email key;
    };
  };
  python.enable = true;
  shell = {
    bash = true;
    zsh = true;
    fish = true;
    enableAliases = true;
  };
}

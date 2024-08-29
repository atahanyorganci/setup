{ pkgs, user, ... }:
{
  imports = [
    ../../modules/home-manager
  ];
  home = {
    username = user.username;
    homeDirectory = "/home/${user.username}";
    packages = with pkgs; [ hello ];
  };
  alacritty.enable = true;
  git = {
    enable = true;
    user = {
      inherit (user) name email key;
    };
  };
  kitty = {
    enable = true;
    font.name = "Cascadia Code NF";
  };
  node.enable = true;
  python.enable = true;
  shell = {
    bash = true;
    fish = true;
    enableAliases = true;
    enableFishShellPatch = true;
  };
}

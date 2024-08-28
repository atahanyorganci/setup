{ pkgs, user, ... }:
{
  imports = [
    ./modules/home-manager
  ];
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
  python.enable = true;
}

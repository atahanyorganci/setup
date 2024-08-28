{ pkgs, user, ... }:
{
  # Compability with NixOS
  home.stateVersion = "24.05";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Import modules
  imports = [
    ./modules/home-manager/kitty.nix
    ./modules/home-manager/git.nix
    ./modules/home-manager/shell.nix
    ./modules/home-manager/python.nix
    ./modules/home-manager/alacritty
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

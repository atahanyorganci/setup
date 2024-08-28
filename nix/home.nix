{ pkgs, user, ... }:
{
  # Compability with NixOS
  home.stateVersion = "24.05";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Import modules
  imports = [
    ./modules/kitty.nix
    ./modules/git.nix
    ./modules/shell.nix
    ./modules/python.nix
    ./modules/alacritty.nix
  ];
  kitty = {
    enable = true;
    font.name = "Cascadia Code NF";
  };
  git = {
    enable = true;
    user = {
      inherit (user) name email key;
    };
  };
  alacritty.enable = true;
}

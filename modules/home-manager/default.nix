inputs: {
  # Compability with NixOS
  home.stateVersion = "24.05";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Individual imports
  imports = [
    ./alacritty
    ./git.nix
    ./kitty.nix
    ./node.nix
    ./python
    ./shell.nix
  ];
}

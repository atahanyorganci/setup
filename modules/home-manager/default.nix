inputs: {
  # Compability with NixOS
  home.stateVersion = "24.05";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Setup XDG directories and environment variables
  xdg.enable = true;
  # Individual imports
  imports = [
    ./alacritty
    ./ffmpeg.nix
    ./git
    ./gum.nix
    ./kitty.nix
    ./node.nix
    ./python
    ./shell.nix
    ./tools.nix
    ./wget.nix
  ];
}

inputs: {
  # Compability with NixOS
  home.stateVersion = "24.05";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Setup XDG directories and environment variables
  xdg.enable = true;
  # Individual imports
  imports = [
    ./alacritty.nix
    ./ffmpeg.nix
    ./firefox.nix
    ./git
    ./gum.nix
    ./kitty.nix
    ./node.nix
    ./pass.nix
    ./python
    ./shell.nix
    ./tools.nix
    ./wget.nix
  ];
}

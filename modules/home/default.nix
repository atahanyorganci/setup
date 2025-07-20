inputs: {
  # Compatibility with NixOS
  home.stateVersion = "24.05";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  # Setup XDG directories and environment variables
  xdg.enable = true;
  # Individual imports
  imports = [
    ./alacritty
    ./ffmpeg
    ./firefox
    ./git
    ./gnome
    ./gpg
    ./gum
    ./kitty
    ./node
    ./pass
    ./python
    ./shell
    ./tools
    ./user
    ./uutils
    ./vscode
    ./wget
  ];
}

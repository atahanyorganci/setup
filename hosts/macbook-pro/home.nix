{ pkgs, user, inputs, ... }:
{
  imports = [
    inputs.firefox-darwin.darwinModules.home-manager
    ../../modules/home-manager
  ];
  home.packages = with inputs.nix-casks.packages.${pkgs.system}; [
    orbstack
    raycast
    slack
    whatsapp
    brave-browser
    vlc
    tableplus
    responsively
  ];
  alacritty.enable = true;
  ffmpeg.enable = true;
  firefox.enable = true;
  git = {
    enable = true;
    aliases.enable = true;
    user = {
      inherit (user) name email key;
    };
  };
  gum.enable = true;
  kitty.enable = true;
  python.enable = true;
  shell = {
    bash.enable = true;
    zsh.enable = true;
    fish.enable = true;
  };
  tools.enable = true;
  vscode.enable = true;
  wget.enable = true;
}

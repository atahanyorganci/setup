{ flake
, pkgs
, ...
}:
let
  inherit (flake) inputs;
in
{
  imports = with inputs; [
    self.homeModules.default
    firefox-darwin.darwinModules.home-manager
  ];
  home.packages = with inputs.nix-casks.packages.${pkgs.system}; [
    raycast
    discord
    whatsapp
    orbstack
  ];
  user = {
    name = "Atahan Yorgancı";
    email = "atahan.yorganci@synnada.ai";
    username = "atahan";
    shell = "fish";
    key = "EE530DF5F568D5EB";
  };
  alacritty.enable = true;
  firefox.enable = true;
  git = {
    enable = true;
    aliases.enable = true;
  };
  gum.enable = true;
  python.enable = true;
  shell = {
    bash.enable = true;
    zsh.enable = true;
    fish.enable = true;
  };
  tools.enable = true;
  vscode.enable = true;
  uutils.enable = true;
  wget.enable = true;
}

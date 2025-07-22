{ flake
, pkgs
, lib
, config
, ...
}:
let
  inherit (flake) inputs;
  isDarwin = lib.strings.hasSuffix "darwin" pkgs.system;
  isLinux = lib.strings.hasSuffix "linux" pkgs.system;
  caskName = "ghostty";
  pkg =
    if isDarwin
    then inputs.nix-casks.packages.${pkgs.system}.${caskName}
    else pkgs.ghostty;
in
{
  options.ghostty.enable = lib.mkEnableOption "Visual Studio Code";
  config = lib.mkIf config.ghostty.enable {
    home = {
      packages = [ pkg ];
      sessionVariables.EDITOR = "code --wait";
    };
    programs.ghostty = {
      enable = true;
      package = pkg;
      enableBashIntegration = config.shell.bash.enable;
      enableZshIntegration = config.shell.zsh.enable;
      enableFishIntegration = config.shell.fish.enable;
      settings = {
        "window-padding-x" = 8;
        "window-padding-y" = 8;
        keybind = [
          "global:shift+alt+r=reload_config"
        ];
      };
    };
  };
}

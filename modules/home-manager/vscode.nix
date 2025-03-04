{ lib
, config
, inputs
, pkgs
, ...
}:
let
  pkg =
    if lib.strings.hasSuffix "darwin" pkgs.system
    then inputs.nix-casks.packages.${pkgs.system}.visual-studio-code
    else pkgs.vscode;
in
{
  options.vscode.enable = lib.mkEnableOption "Visual Studio Code";
  config = lib.mkIf config.vscode.enable {
    home.sessionVariables = {
      EDITOR = "code --wait";
    };
    programs.vscode = {
      package = pkg;
      enable = true;
      enableUpdateCheck = true;
    };
    stylix.targets.vscode.enable = false;
  };
}

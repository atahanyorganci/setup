{ lib
, config
, ...
}:
{
  options.vscode.enable = lib.mkEnableOption "Visiual Studio Code";
  config = lib.mkIf config.vscode.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = true;
    };
    stylix.targets.vscode.enable = false;
  };
}

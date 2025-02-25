{ lib
, config
, user
, pkgs
, ...
}:
let
  shell = pkgs.${user.shell};
  shellBin = "${shell}/bin/${user.shell}";
in
{
  options.alacritty = {
    enable = lib.mkEnableOption "Alacritty Terminal";
  };
  config = lib.mkIf config.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        terminal.shell = {
          args = [ "-l" ];
          program = shellBin;
        };
        font = {
          size = 12;
        };
        window = {
          decorations = "Full";
          dimensions = {
            columns = 100;
            lines = 50;
          };
          padding = {
            x = 8;
            y = 8;
          };
          position = {
            x = 32;
            y = 32;
          };
        };
      };
    };
  };
}

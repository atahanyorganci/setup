{ flake
, lib
, config
, pkgs
, ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) nixpkgs;
  shell = pkgs.${config.user.shell};
  shellBin = "${shell}/bin/${config.user.shell}";
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
          size = lib.mkForce config.terminal.font.size;
        };
        window = {
          decorations = "Full";
          dimensions = config.terminal.dimensions;
          padding = config.terminal.padding;
          position = config.terminal.position;
        };
      };
    };
  };
}

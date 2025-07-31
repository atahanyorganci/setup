{ pkgs, ... }:
let
  main = pkgs.cascadia-code;
in
{
  fonts.packages = [ main ];
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    fonts = {
      monospace = {
        package = main;
        name = "Cascadia Code NF";
      };
    };
  };
}

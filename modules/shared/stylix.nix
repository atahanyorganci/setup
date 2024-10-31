{ pkgs, ... }:
let
  main = pkgs.cascadia-code;
in
{
  fonts.packages = [ main ];
  stylix = {
    enable = true;
    image = ../../assets/new-york-night.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    fonts = {
      monospace = {
        package = main;
        name = "Cascadia Code NF";
      };
    };
  };
}

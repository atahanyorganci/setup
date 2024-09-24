{ pkgs, ... }:
{
  stylix = {
    enable = true;
    image = ../../assets/new-york-night.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
    fonts = {
      monospace = {
        package = pkgs.cascadia-code;
        name = "Cascadia Code NF";
      };
    };
  };
}

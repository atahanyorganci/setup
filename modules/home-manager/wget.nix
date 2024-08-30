{ pkgs
, lib
, config
, ...
}:
{
  options.wget = lib.mkEnableOption "wget";
  config = {
    home.file."${config.xdg.configHome}/wgetrc".text = "";
    home.shellAliases.wget = "${pkgs.wget}/bin/wget --hsts-file=${config.xdg.cacheHome}/wget-hsts";
    home.sessionVariables.WGETRC = "${config.xdg.configHome}/wgetrc";
    home.packages = [ pkgs.wget ];
  };
}

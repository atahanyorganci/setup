{ pkgs
, config
, ...
}:
{
  programs.gpg.enable = true;
  programs.ssh = {
    enable = true;
    includes = [ "~/.orbstack/ssh/config" ];
  };
  home.sessionVariables = {
    SSH_AUTH_SOCK = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";
  };
}

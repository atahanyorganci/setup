{
  config,
  pkgs,
  user,
  ...
}:
{
  imports = [
    ../../modules/home-manager
  ];
  home = {
    username = user.username;
    homeDirectory = "/home/${user.username}";
    packages = with pkgs; [ hello ];
  };
}

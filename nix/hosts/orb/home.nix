{ pkgs, user, ... }:
{
  imports = [
    ../../modules/home-manager
  ];
  git = {
    enable = true;
    user = {
      inherit (user) name email key;
    };
  };
  python.enable = true;
}

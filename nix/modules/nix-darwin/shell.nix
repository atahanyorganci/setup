{ pkgs, ... }:
let
  shells = with pkgs; [
    bashInteractive
    zsh
    fish
  ];
in
{
  environment.shells = shells;
  environment.systemPackages = shells;
}

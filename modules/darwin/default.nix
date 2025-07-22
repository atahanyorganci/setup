{ flake
, pkgs
, ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
  shared = self + /modules/shared;
in
{
  imports = [
    shared
    ./firefox
    ./homebrew
    ./shell
  ];
}

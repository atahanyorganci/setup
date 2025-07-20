{ flake, lib, ... }:

let
  inherit (flake) inputs;
  inherit (inputs) self nixpkgs;
  user = {
    name = "Atahan Yorgancı";
    email = "atahanyorganci@hotmail.com";
    username = "atahan";
    shell = "fish";
    key = "F3F2B2EDB7562F09";
  };
  workUser = {
    inherit (user) name username shell;
    email = "atahan.yorganci@synnada.ai";
    key = "EE530DF5F568D5EB";
  };
  system = "aarch64-darwin";
  pkgs = import nixpkgs {
    inherit system;
    config = {
      allowUnfree = true;
      allowBroken = true;
    };
  };
in
{
  imports = with inputs; [
    self.darwinModules.default
    home-manager.darwinModules.home-manager
    stylix.darwinModules.stylix
    {
      home-manager.users.${user.username} = self + /configurations/home/atahan;
    }
  ];
  nixpkgs.hostPlatform = system;
  # Disable `nix-darwin` documentation
  documentation.enable = false;
  # Allow `nix-darwin` to manage `nix`
  nix.enable = false;
  # Applications installed by Homebrew
  homebrew.casks = [
    "google-chrome"
    "spotify"
    "orbstack"
    "cloudflare-warp"
  ];
  # Enable entering sudo mode with Touch ID.
  security.pam.services.sudo_local.touchIdAuth = true;
  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  # Ensures compatibility with defaults from NixOS
  system.stateVersion = 4;
  # User used for options that previously applied to the user running `darwin-rebuild`
  system.primaryUser = user.username;
  # Users managed by Nix
  users.knownUsers = [ user.username ];
  users.users.${user.username} = {
    name = user.username;
    description = user.name;
    home = "/Users/${user.username}";
    shell = pkgs.${user.shell};
    # User ID created by MacOS for the user use `id -u` to get it.
    uid = 501;
  };
}

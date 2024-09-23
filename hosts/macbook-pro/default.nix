{ pkgs, user, inputs, ... }:
let
  # User ID created by MacOS for the user use `id -u` to get it.
  uid = 501;
in
{
  imports = [
    ../../modules/nix-darwin/firefox.nix
    ../../modules/nix-darwin/homebrew.nix
    ../../modules/nix-darwin/shell.nix
    ../../modules/shared/stylix.nix
  ];
  # Disable `nix-darwin` documentation
  documentation.enable = false;
  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  # Run garbage collection automatically every Sunday at 2am.
  nix.gc.automatic = true;
  nix.gc.interval = [
    {
      Hour = 2;
      Weekday = 0;
    }
  ];
  # Add custom overlay for Firefox on MacOS.
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  homebrew.apps = {
    orbstack = false;
    raycast = false;
    slack = false;
    visual-studio-code = false;
    whatsapp = false;
  };
  # Enable entering sudo mode with Touch ID.
  security.pam.enableSudoTouchIdAuth = true;
  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  # Ensures compatibility with defaults from NixOS
  system.stateVersion = 4;
  # Users managed by Nix
  users.knownUsers = [ user.username ];
  users.users.${user.username} = {
    name = user.username;
    description = user.name;
    home = "/Users/${user.username}";
    shell = pkgs.${user.shell};
    uid = uid;
  };
}

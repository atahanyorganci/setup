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
  ];
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

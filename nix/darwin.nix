inputs@{ pkgs, user, ... }:
{
  documentation.enable = false;
  fonts.packages = [ pkgs.cascadia-code ];
  # Install GUI applications using Homebrew so they are available in Spotlight.
  homebrew.enable = true;
  homebrew.casks = [
    "whatsapp"
    "slack"
    "spotify"
    "firefox"
    "google-chrome"
    "visual-studio-code"
    "alacritty"
    "raycast"
    "orbstack"
  ];
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
  # Enable entering sudo mode with Touch ID.
  security.pam.enableSudoTouchIdAuth = true;
  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
  # Ensures compatibility with defaults from NixOS
  system.stateVersion = 4;
  # Users
  users.users.${user.username} = {
    name = user.username;
    description = user.name;
    home = "/Users/${user.username}";
    shell = pkgs.${user.shell};
  };
}

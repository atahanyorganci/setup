{
  description = "NixOS configuration for Atahan's MacBook Pro";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      documentation.enable = false;
      # Packages from `nixpkgs` to be installed on the system.
      environment.systemPackages = with pkgs; [
          vim
          fzf
          pandoc
          nixfmt-rfc-style
          starship
          gh
          eza
          bat
          delta
          just
          fd
          dust
          hyperfine
          zoxide
          gum
          poetry
          pipx
          gnupg
        ];
      fonts.packages = [
        pkgs.cascadia-code
      ];
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
        "kitty"
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
      # Enable `bash`, `zsh`, and `fish` shells.
      programs.bash.enable = true;
      programs.zsh.enable = true;
      programs.fish.enable = true;
      # Enable entering sudo mode with Touch ID.
      security.pam.enableSudoTouchIdAuth = true;
      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;
      # Ensures compatibility with defaults from NixOS
      system.stateVersion = 4;
      # CPU architecture for the system.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Atahan-MacBook-Pro
    darwinConfigurations."Atahan-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Atahan-MacBook-Pro".pkgs;
  };
}
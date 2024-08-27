{
  description = "NixOS configuration for Atahan's MacBook Pro";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Atahan-MacBook-Pro
    darwinConfigurations."Atahan-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      # CPU architecture for the system.
      system = "aarch64-darwin";
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.verbose = true;
          home-manager.users.atahan = ./home.nix;
        }
      ];
      specialArgs = { inherit inputs; };
    };
    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Atahan-MacBook-Pro".pkgs;
  };
}

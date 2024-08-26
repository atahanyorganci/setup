{
  description = "NixOS configuration for Atahan's MacBook Pro";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nix-darwin, nixpkgs, ... }: {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Atahan-MacBook-Pro
    darwinConfigurations."Atahan-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [ ./darwin.nix ];
      specialArgs = { inherit inputs; };
    };
    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."Atahan-MacBook-Pro".pkgs;
  };
}

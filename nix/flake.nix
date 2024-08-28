{
  description = "NixOS configuration for Atahan's MacBook Pro";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      user = {
        name = "Atahan Yorgancı";
        email = "atahanyorganci@hotmail.com";
        username = "atahan";
        shell = "fish";
        key = "F3F2B2EDB7562F09";
      };
    in
    {
      darwinConfigurations."Atahan-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        # CPU architecture for the system.
        system = "aarch64-darwin";
        modules = [
          ./hosts/macbook-pro/configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.${user.username} = ./hosts/macbook-pro/home.nix;
            home-manager.extraSpecialArgs = {
              inherit user;
            };
          }
        ];
        specialArgs = {
          inherit user inputs;
        };
      };
    };
}

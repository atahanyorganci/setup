{ config
, pkgs
, modulesPath
, user
, inputs
, ...
}:
{
  imports = [
    # Include the default lxd configuration.
    "${modulesPath}/virtualisation/lxc-container.nix"
    # Include the OrbStack-specific configuration.
    ./orbstack.nix
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.verbose = true;
      home-manager.users.${user.username} = ./home.nix;
      home-manager.extraSpecialArgs = { inherit user inputs; };
    }
  ];
  users = {
    # This being `true` leads to a few nasty bugs, change at your own risk!
    mutableUsers = false;
    # Shared user
    users.${user.username} = {
      uid = 501;
      extraGroups = [ "wheel" ];
      isSystemUser = true;
      group = "users";
      createHome = true;
      home = "/home/${user.username}";
      homeMode = "700";
      shell = pkgs.${user.shell};
    };
  };
  programs.${user.shell}.enable = true;
  # Enable Home Manager for the user
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.verbose = true;
  home-manager.users.${user.username} = ./home.nix;
  home-manager.extraSpecialArgs = {
    inherit user inputs;
  };
  # Hostname of the system
  networking.hostName = "orb";
  # Disable password for `sudo` command.
  security.sudo.wheelNeedsPassword = false;
  # Timezone
  time.timeZone = "Europe/Istanbul";
  # NixOS version
  system.stateVersion = "24.05";
}

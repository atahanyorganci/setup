{
  config,
  pkgs,
  modulesPath,
  user,
  ...
}:
{
  imports = [
    # Include the default lxd configuration.
    "${modulesPath}/virtualisation/lxc-container.nix"
    # Include the OrbStack-specific configuration.
    ./orbstack.nix
  ];
  # This being `true` leads to a few nasty bugs, change at your own risk!
  users.mutableUsers = false;
  # Shared user
  users.users.${user.username} = {
    uid = 501;
    extraGroups = [ "wheel" ];
    isSystemUser = true;
    group = "users";
    createHome = true;
    home = "/home/${user.username}";
    homeMode = "700";
    shell = pkgs.${user.shell};
  };
  programs.${user.shell}.enable = true;
  # Hostname of the system
  networking.hostName = "orb";
  # Disable password for `sudo` command.
  security.sudo.wheelNeedsPassword = false;
  # Timezone
  time.timeZone = "Europe/Istanbul";
  # NixOS version
  system.stateVersion = "24.05";
}

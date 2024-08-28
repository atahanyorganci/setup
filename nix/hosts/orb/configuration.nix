{ config, pkgs, modulesPath, ... }:

{
  imports =
    [
      # Include the default lxd configuration.
      "${modulesPath}/virtualisation/lxc-container.nix"
      # Include the OrbStack-specific configuration.
      ./orbstack.nix
    ];
  users.users.atahan = {
    uid = 501;
    extraGroups = [ "wheel" ];
    isSystemUser = true;
    group = "users";
    createHome = true;
    home = "/home/atahan";
    homeMode = "700";
    useDefaultShell = true;
  };

  security.sudo.wheelNeedsPassword = false;

  # This being `true` leads to a few nasty bugs, change at your own risk!
  users.mutableUsers = false;

  time.timeZone = "Europe/Istanbul";
  networking = {
    hostName = "orb";
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };
  systemd.network = {
    enable = true;
    networks."50-eth0" = {
      matchConfig.Name = "eth0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };

  system.stateVersion = "24.05";
}

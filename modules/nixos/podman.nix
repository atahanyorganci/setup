{ lib, config, ... }:
{
  options.podman.enable = lib.mkEnableOption "Podman";
  config = lib.mkIf config.podman.enable {
    virtualisation = {
      containers.enable = true;
      oci-containers.backend = "podman";
      podman = {
        enable = true;
        # Create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = true;
        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
      };
    };
  };
}

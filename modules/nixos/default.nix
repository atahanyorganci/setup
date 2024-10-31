inputs: {
  # Compability with NixOS
  system.stateVersion = "24.05";
  # Individual imports
  imports = [
    ./gnome.nix
    ./podman.nix
  ];
}

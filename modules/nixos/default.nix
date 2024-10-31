inputs: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Enable flakes and nix commands
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Compability with NixOS
  system.stateVersion = "24.05";
  # Individual imports
  imports = [
    ./gnome.nix
    ./podman.nix
  ];
}

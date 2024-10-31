{ config, pkgs, user, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/shared/stylix.nix
    ../../modules/nixos
  ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Networking
  networking = {
    hostName = "yoga";
    networkmanager.enable = true;
  };
  # Time Zone
  time.timeZone = "Europe/Istanbul";
  # Internationzaliztion
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };
  # Gnome Desktop
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };
  # Configure console keymap
  console.keyMap = "trq";
  # Enable CUPS to print documents.
  services.printing.enable = true;
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # Enable flakes and nix commands
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user.username} = {
    isNormalUser = true;
    description = user.name;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      bitwarden-desktop
    ];
  };
  # Enable GPG for SSH and commit signing
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  # Remove Gnome applications
  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gnome-calendar
    gnome-weather
    gnome-contacts
    gnome-maps
    gedit
    gnome-music
    epiphany
    geary
    gnome-characters
    totem
    yelp
  ]);
  system.stateVersion = "24.05";
}

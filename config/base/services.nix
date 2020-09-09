{ config, lib, pkgs, ... }:

with lib;
with (import ./util.nix lib);

# The essential stuff
# What is essential?
#  - Tiny background services that don't add much res-usage but prove to be very useful
#  - Services that apps need to run properly
#  - System-internal things that do their job in the background
#  - Packages for hardware that most devices have (for ex bluetooth is on by default. but the laptop might not have it, so it's a feature)

makeDefault {
  # Enable GPG agent
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # Firmware updates
  services.fwupd.enable = true;

  # Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # GVFS - pretty essential service, many apps need it for stuff like trash
  services.gvfs.enable = true;

  # Faster boot through entropy seeding
  services.haveged.enable = true;

  # Trim the SSD once a week
  services.fstrim.enable = true;

  # Power managment for laptops
  services.tlp.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # Equalizer config
  hardware.pulseaudio.extraConfig = ''
    load-module module-equalizer-sink
    load-module module-dbus-protocol
  '';

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  services.xserver.updateDbusEnvironment = true;

  # Enable powerManagment
  powerManagement.enable = true;
  services.upower.enable = true;
  # services.acpid.enable = true;

  # More essential stuff
  security.polkit.enable = true;
  services.accounts-daemon.enable = true;
  services.gnome3.glib-networking.enable = true;
  services.gnome3.gnome-keyring.enable = true;
  services.udisks2.enable = true;
  services.geoclue2.enable = true;
  networking.networkmanager.enable = true;

  # Enable colord server
  services.colord.enable = true;
}

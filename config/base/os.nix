{ config, lib, pkgs, ... }:

with lib;
# with (import ./util.nix lib);

{
  config = {
    boot.plymouth = {
      enable = true;
    };

    boot.kernelPackages = if config.solar.features.libre then pkgs.linuxPackages-libre else pkgs.linuxPackages; # uses latest LTS (currently 5.4)
    hardware.enableRedistributableFirmware = !config.solar.features.libre;

    services.xserver = {
      enable = true;

      # touchpad
      libinput.enable = true;

      # you know, for login
      displayManager.lightdm = {
        enable = true;
      };
    };

    channels = {
      /* links = ''
        https://github.com/mkg20001/nixpkgs/archive/mkg-patch-a.tar.gz nixos
        https://github.com/ssd-solar/solaros-nix/archive/master.tar.gz solaros
        https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
      ''; */

      links = ''
        https://nix.ssd-solar.dev/dev/nixos nixos
        https://nix.ssd-solar.dev/dev/nixos-hardware nixos-hardware
        https://nix.ssd-solar.dev/dev/solaros solaros
        https://nix.ssd-solar.dev/dev/solarpkg solarpkg
      '';
    };
  };

  options = {
    solar.features.libre = mkOption {
      type = types.bool;
      description = "Enable libre kernel & remove unfree software";
      default = false;
    };
  };
}

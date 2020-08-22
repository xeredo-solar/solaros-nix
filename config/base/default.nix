{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    # extra modules
    ./_channels.nix
    ./_bundles.nix

    # these files set branding stuff and add branding packages, don't enable any flags
    ../features/branding.nix

    # these files set optional states (TODO: mkDefault)
    ./os.nix
    ./services.nix

    # just adds packages
    ../features/software.nix

    # features
    ../features/bluetooth.nix
    ../features/printing.nix
    ../features/xr.nix
  ];

  # Disable this, because it breaks stuff
  networking.wireless.enable = lib.mkForce false;
}

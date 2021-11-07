{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./base
    ./de
    ./flakes.nix
  ];

  # NOTE: overlays are now imported via nixosModules.overlays
  # since we can't reference the flake itself from here easily

  # nixpkgs.config.allowUnfree will be activated by installer
  # we are NOT allowed to redistribute propriatery stuff in the ISO

  # add solar cache
  nix = {
    binaryCaches = [
      "https://solar.cachix.org"
    ];
    binaryCachePublicKeys = [
      "solar.cachix.org-1:7j5FItAzYXltOuKmDtHK6gw96LTPUxFs5OlTiRfklJg="
    ];
  };
}

import (import ./lib/nixpkgs.nix) {
  overlays = [
    (import ./pkgs/overlay.nix)
  ];
}

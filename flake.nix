{
  description = "solarOS";

  inputs = {

    /* nix run nixos.nix-prefetch-github -c nix-prefetch-github mkg20001 nixpkgs --rev mkg-patch-a > lib/nixpkgs.json
    nix run nixos.nix-prefetch-github -c nix-prefetch-github mkg20001 nix-node-package --rev master > lib/nix-node-package.json
    nix run nixos.nix-prefetch-github -c nix-prefetch-github nixos nixos-hardware --rev master > lib/nixos-hardware.json
    nix run nixos.nix-prefetch-github -c nix-prefetch-github ssd-solar solarpkg --rev master > lib/solarpkg.json */

    nixpkgs.url = "github:mkg20001/nixpkgs/mkg-patch-a";
    nix-node-package.url = "github:mkg20001/nix-node-package/master";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    # solarpkg.url = "github:ssd-solar/solarpkg/master";
  };

  outputs = { self, nixpkgs, nixos-hardware, nix-node-package }: {

    # packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    # defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;

  };
}

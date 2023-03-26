#!/bin/bash

nix run nixpkgs#nix-prefetch-github -- mkg20001 nixpkgs --rev mkg-patch-a > lib/nixpkgs.json
nix run nixpkgs#nix-prefetch-github -- mkg20001 nix-node-package --rev master > lib/nix-node-package.json
nix run nixpkgs#nix-prefetch-github -- nixos nixos-hardware --rev master > lib/nixos-hardware.json
nix run nixpkgs#nix-prefetch-github -- ssd-solar solarpkg --rev master > lib/solarpkg.json

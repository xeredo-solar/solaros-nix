{
  description = "solarOS";

  inputs = {

    nixpkgs.url = "github:mkg20001/nixpkgs/mkg-patch-a";
    nix-node-package.url = "github:mkg20001/nix-node-package/master";
    nix-node-package.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    # solarpkg.url = "github:ssd-solar/solarpkg/master";
    # solarpkg.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self
    , nixpkgs
    , nix-node-package
    , nixos-hardware
    , ...
    } @ inputs:
    let
      nameValuePair = name: value: { inherit name value; };
      genAttrs = names: f: builtins.listToAttrs (map (n: nameValuePair n (f n)) names);
      # allSystems = [ "x86_64-linux" "aarch64-linux" "i686-linux" "x86_64-darwin" ];
      allSystems = [ "x86_64-linux" ];

      solarLibOverlay = final: prev: {
        mkNode = nix-node-package.lib.nix-node-package prev;
        sFetchSrc = source: prev.fetchFromGitHub (builtins.fromJSON (builtins.readFile source));
        nixpkgs = nixpkgs;
      };

      solarPkgOverlay = final: prev:
        import ./pkgs prev;

      genericForAllSystems = f: genAttrs allSystems (system: f system);

      forAllSystems = f: genAttrs allSystems (system: f {
        inherit system;
        pkgs = import nixpkgs {
          inherit system;
          overlays = (builtins.attrValues self.overlays);
        };
      });
    in
    {
      devShell = forAllSystems ({ system, pkgs, ... }:
        pkgs.mkShell {
          name = "solar-dev";

          # inputsFrom = [ self.packages.${system}.... ];
        });

      packages = forAllSystems
        ({ system, pkgs, ... }:
          import ./pkgs pkgs);

      checks = genericForAllSystems (system: import ./tests (
        f: import "${nixpkgs}/nixos/tests/make-test-python.nix" f { inherit system; }
      ));

      lib = {
        inherit
          forAllSystems
          genericForAllSystems
          nixpkgs;
      };

      overlays = {
        inherit
          solarPkgOverlay
          solarLibOverlay;
      };

      # defaultPackage = forAllSystems ({ system, ... }: self.packages.${system}.pijul);
    };
}

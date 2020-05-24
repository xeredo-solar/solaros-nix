{ lib, pkgs, ... }:
let
  nixNodePackage = pkgs.callPackage ./nix-node-package.nix {};
  mkNode = import "${nixNodePackage}/nix/default.nix" pkgs;

  installerSrcData = builtins.fromJSON (builtins.readFile ./nixinstall/source.json);
  installerSrc = pkgs.fetchFromGitHub {
    repo = "nixinstall";
    owner = "mercode-org";
    rev = installerSrcData.rev;
    sha256 = installerSrcData.sha256;
  };
  nixinstall = lib.recurseIntoAttrs (pkgs.callPackage "${installerSrc}/nix" { });

  makeIcon = pkgs.callPackage ./make-icon {};

  recursiveIterateRecreate = set: iter:
    builtins.listToAttrs(
      builtins.concatMap iter (builtins.attrNames set)
    );

  solaros-skel-base = pkgs.callPackage ./solaros-skel-base {};

in
{
  solarosNixpkgs = import ../lib/nixpkgs.nix;
  solarosNixosHardware = import ../lib/nixos-hardware.nix;
  solaros = lib.cleanSource ../.;

  inherit makeIcon nixNodePackage nixinstall solaros-skel-base;

  conf-tool = pkgs.callPackage ./conf-tool {
    inherit mkNode;
  };

  solaros-skel-cinnamon = pkgs.callPackage ./solaros-skel-cinnamon {
    inherit solaros-skel-base;
  };
  solaros-skel-mate = pkgs.callPackage ./solaros-skel-mate {
    inherit solaros-skel-base;
  };
  solaros-skel-xfce = pkgs.callPackage ./solaros-skel-xfce {
    inherit solaros-skel-base;
  };

  solaros-installer = (nixinstall.nixinstall.override {
    # slideshowPackage = todo; # TODO: add slideshow support to elementary-installer
  }).overrideAttrs(pkg: pkg // {
    name = "solaros-installer";

    postFixup = ''
      ln -s $out/bin/io.elementary.installer $out/bin/solaros-installer
      sed -i "s|io.elementary.installer|solaros-installer|g" -i $out/share/applications/*
      sed -ir 's|( *)[eE]*lementary *[oO]*[sS]*|\0solarOS|g' -i $out/share/applications/*
    '';
  });

  solarosBundles = lib.makeScope pkgs.newScope (self:
    let
      bundles = (import ../config/base/bundles.nix pkgs).solaros.bundle;
    in
      recursiveIterateRecreate bundles (key:
        let
          value = bundles.${key};
        in
          [(lib.nameValuePair key (pkgs.symlinkJoin {
            name = "solaros-bundle-${key}";
            paths = value.pkgs;

            meta = {
              description = if lib.hasAttrByPath ["description"] value then value.description else null;
            };
          }))]));
}

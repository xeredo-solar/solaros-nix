{ config, pkgs, lib, ... }:

with lib;

{
  options = {
    solar.bundle-preload = mkOption {
      type = types.bool;
      description = "Whether to preload bundles by default, useful for installer";
      default = false;
    };

    solar.bundle = mkOption {
      type = with types; attrsOf (submodule ({ name, ... }: {
        options = {
          name = mkOption {
            type = types.str;
            description = "Bundle name (camel-case)";
          };

          pkgs = mkOption {
            type = types.listOf types.package;
            description = "Packages to be added";
          };

          enable = mkOption {
            type = types.bool;
            description = "Whether this bundle should be enabled";
            default = config.solar.bundle-preload;
          };
        };

        config = {
          name = mkDefault name;
        };
      }));
    };
  };

  config = {
    environment.systemPackages = builtins.concatMap (bundle: if bundle.enable then bundle.pkgs else []) (builtins.attrValues config.solar.bundle);
  };
}

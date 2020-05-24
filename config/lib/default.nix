{ config, lib, pkgs, ... }:

with lib;

{
  mkFeatureFlag = { name, desc ? "${name} feature", enabled ? false, extraOptions ? {} }: featureConfig:
    {
      config = mkIf config.solar.features.${name} featureConfig;

      options = {
        solar.features.${name} = mkOption {
          type = types.bool;
          description = desc;
          default = enabled;
        };
      } // extraOptions;
    };

  mkAutostart = list:
    let
      cmds = builtins.concatStringsSep "\n"
        (forEach list (item: let
          pkg = if builtins.isList item then elemAt 0 item else item;
          name = if builtins.isList item then elemAt 1 item else item;
          in
            ''
              install -D "${pkgs.${pkg}}/share/applications/${name}.desktop" "$out/etc/xdg/autostart/${name}.desktop"
            ''));
    in
      pkgs.runCommand "autostart" {} cmds;
} // lib // builtins

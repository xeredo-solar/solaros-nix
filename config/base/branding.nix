{ config, lib, pkgs, ... }:

with lib;

{
  # NOTE: this file shouldn't enable anything, just set the branding attributes

  services.xserver.displayManager.lightdm = {
    # background = "..."; # TODO
    greeters.gtk = {
      iconTheme = {
        # package = pkgs.todo;
        # name = "todo";
      };

      extraConfig = ''
        cursor-theme=todo
        theme-name=todo
        xft-antialias=true
        xft-hintstyle=hintfull
        xft-rgba=rgb
      '';
    };
  };

  # boot.loader.grub.theme = pkgs.todo;

  environment.systemPackages = with pkgs; [
    # design
    # TODO

    # system
    # TODO
  ];

  environment.pathsToLink = [
    "/share/wallpapers"
  ];

  fonts.fonts = with pkgs; [
    raleway
    jetbrains-mono
  ];

  fonts.fontconfig.defaultFonts.monospace = [ "Jetbrains Mono Regular" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "Raleway Medium" ];
}

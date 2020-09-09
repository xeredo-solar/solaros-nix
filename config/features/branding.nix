{ config, lib, pkgs, ... } @ args:

with (import ../lib args);

mkFeatureFlag { name = "branding"; desc = "SolarOS branding"; enabled = true; } {
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
    # vanilla-dmz (wait for license fix merge)

    # system
    # TODO
  ];

  environment.pathsToLink = [
    "/share/wallpapers"
  ];

  # Default Fonts
  fonts.fonts = with pkgs; [
    # branding
    raleway
    jetbrains-mono
    ubuntu_font_family

    # also add
    open-sans
    roboto-mono

    # default things
    cantarell-fonts
    dejavu_fonts
    source-code-pro # Default monospace font in 3.32
    source-sans-pro
  ];

  fonts.fontconfig.defaultFonts.monospace = [ "Jetbrains Mono Regular" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "Raleway Medium" ];
}

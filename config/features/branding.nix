{ config, lib, pkgs, ... } @ args:

with (import ../lib args);

mkFeatureFlag { name = "branding"; desc = "SolarOS branding"; enabled = true; } {
  # NOTE: this file shouldn't enable anything, just set the branding attributes

  # sys theme Flat-Remix-GTK-Blue-Darker

  services.xserver.displayManager.lightdm = {
    # background = "..."; # TODO
    greeters.gtk = {
      iconTheme = {
        package = pkgs.flat-remix-icon-theme;
        name = "Flat-Remix-Blue";
      };

      extraConfig = ''
        cursor-theme=DMZ-Black
        theme-name=Flat-Remix-GTK-Blue
        xft-antialias=true
        xft-hintstyle=hintfull
        xft-rgba=rgb
      '';
    };
  };

  # boot.loader.grub.theme = pkgs.todo;

  environment.systemPackages = with pkgs; [
    # design
    # flat-remix-icon-theme
    # flat-remix-gtk
    papirus-icon-theme
    equilux-theme
    vanilla-dmz

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
    # FIXME: missing
    # source-sans-pro
  ];

  fonts.fontconfig.defaultFonts.monospace = [ "Jetbrains Mono Regular" ];
  fonts.fontconfig.defaultFonts.sansSerif = [ "Raleway Medium" ];
}

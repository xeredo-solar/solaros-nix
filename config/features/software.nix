{ config, lib, pkgs, ... } @ args:

with (import ../lib args);

mkFeatureFlag { name = "software"; desc = "SolarOS default software"; enabled = true; } {
  environment.systemPackages = with pkgs; [
    # external package formats
    flatpak                      # Good software utility to use if you can't find what you want at nixpkgs
    # snapd N/A yet

    # utilities
    git                          # That's git everybody, our favourite scm
    curl                         # HTTP-debugger
    wget                         # The gold standard for CLI downloads
    psmisc                       # Needed utils bundled in a single package
    tree                         # A better version of ls
    gnome3.gnome-system-monitor  # Its pretty understandable from the name, I guess?

    # apps
    cinnamon.nemo                # To show files
    libreoffice                  # Office program that comes with literally every GNU/Linux distro
    wine                         # Tool for people that wanna run Windows programs instead of glorious free software
    shotwell                     # Its just an image viewer
    font-manager                 # The name says everything
    qpaeq                        # Equalizer
    flameshot                    # screenshot tool that supports editing the screenshot in-place
    cinnamon.warpinator          # File-transfer tool
    cinnamon.blueberry           # bt-managment tool

    # cli utils
    htop                         # Interactive process viewer
    lesspipe                     # CLI addon to pipe things through less

    # browsers - TODO: add choice mechanism, so the user can choose the browser post-install
    chromium
    firefox

    # autostart
    (mkAutostart ["flameshot"])  # autostart flameshot with the OS

    # ntfs ro fix
    (hiPrio ntfs3g)
  ];

  programs.geary.enable = true;
  programs.gnome-disks.enable = true;
  programs.gnome-terminal.enable = true;
  programs.file-roller.enable = true;
} // {
  imports = [
    (import ../base/bundles.nix pkgs)
  ];
}

{ config, lib, pkgs, ... } @ args:

with (import ../lib args);

mkFeatureFlag { name = "software"; desc = "SolarOS default software"; enabled = true; } {
  environment.systemPackages = with pkgs; [
    # external package formats
    flatpak                      # Good software utility to use if you can't find what you want at nixpkgs
    # snapd N/A yet

    # sys apps
    conf-tool                    # Config Tool
    nixNodePackage               # A hack to get nix-node package to be available at every eval

    # utilities
    git                          # That's git everybody, our favourite scm
    curl                         # HTTP-debugger
    wget                         # The gold standard for CLI downloads
    gnome3.gnome-disk-utility    # As the name says
    gnome3.file-roller           # A WinRAR that doesn't ask you to pay
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
    cinnamon.warp                # Cinnamon Warp

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
} // {
  imports = [
    (import ../base/bundles.nix pkgs)
  ];
}

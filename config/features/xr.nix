{ config, lib, pkgs, ... } @ args:

with (import ../lib args);

mkFeatureFlag { name = "xr"; desc = "SolarOS Extended Reality / Virtual Reality"; enabled = false; } {
  programs.steam.enable = true;
} // {
  imports = [
    # xrdesktop-overlay
    # simular VR overlay
  ];
}

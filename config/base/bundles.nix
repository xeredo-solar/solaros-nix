pkgs:

{
  solaros.bundle.devTools.pkgs = with pkgs; [ gcc vim cmake gparted ];
  solaros.bundle.editingTools.pkgs = with pkgs; [ gimp inkscape krita ]; # openshot-qt
}

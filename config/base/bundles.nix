pkgs:

{
  solar.bundle.devTools.pkgs = with pkgs; [ gcc vim cmake gparted ];
  solar.bundle.editingTools.pkgs = with pkgs; [ gimp inkscape krita ]; # openshot-qt
}

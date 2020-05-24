pkgs:

{
  config = {
    solar.bundle = {
      devTools.pkgs = with pkgs; [ gcc vim cmake ];
      videoEditingTools.pkgs = with pkgs; [ openshot-qt blender ];
      imageEditingTools.pkgs = with pkgs; [ gimp inkscape krita mypaint ];
    };
  };
}

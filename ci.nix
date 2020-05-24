let
  solarOS = import ./release.nix;

  r = attr:
    { recurseForDerivations = true; } // attr;
in
{
  # inherit (solarOS) isoAll; # disabled since using a lot of resources for nothing, mostly

  vm = r {
    cinnamonVm = solarOS.cinnamon.vm;
    mateVm = solarOS.mate.vm;
    xfceVm = solarOS.xfce.vm;
  };

  tests = r (solarOS.tests {});
  pkgs = r (solarOS.pkgs);
}

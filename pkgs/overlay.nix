let
  removeKeys = [ # if those keys aren't stripped we'll get infinite recursion as we're overwriting those base-keys
    "callPackage"
    "newScope"
    "override"
    "overrideDerivation"
    "overrideScope"
    "overrideScope'"
    "packages"
  ];

  contains = thing: list:
    (builtins.filter (otherThing: otherThing == thing) list) != [];

  filter = lib: pkgs:
    with lib;
    filterAttrs (n: v: !(contains n removeKeys)) pkgs;
in

self: super: (filter super.lib (import ./all-packages.nix super))

prev:
with builtins; with prev;
let
  fetchSrc = source:
    fetchFromGitHub fromJSON (readFile source);
in
rec {
  # utilities for packaging
  makeIcon = callPackage ./make-icon { };

  # system tools
  conf-tool = callPackage ./conf-tool { };
  distinst = callPackage ./distinst { };
}

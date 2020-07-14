let
  fetchFromGitHub = import ./fetchFromGitHub.nix;
  solarpkg = builtins.fromJSON (builtins.readFile ./solarpkg.json);
in
  fetchFromGitHub solarpkg

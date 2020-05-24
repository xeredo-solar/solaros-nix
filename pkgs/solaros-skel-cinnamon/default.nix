{ fetchFromGitHub
, stdenv
, solaros-skel-base
}:

stdenv.mkDerivation rec {
  pname = "solaros-skel-cinnamon";
  version = "0.0.1";

  src = ./skel;

  installPhase = ''
    mkdir -p $out
    find $PWD ${solaros-skel-base} -maxdepth 1 -mindepth 1 -exec cp -r {} $out \;
  '';
}

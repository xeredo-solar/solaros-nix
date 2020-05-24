{ stdenv
, imagemagick
, makeWrapper
}:

stdenv.mkDerivation {
  pname = "make-icon";
  version = "1.0.0";

  dontUnpack = true;

  buildInputs = [
    imagemagick
    makeWrapper
  ];

  installPhase = ''
    install -D ${./make-icon.sh} $out/bin/makeIcon
    wrapProgram $out/bin/makeIcon --prefix PATH : "${imagemagick}/bin"
  '';
}

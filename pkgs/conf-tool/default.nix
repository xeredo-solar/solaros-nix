{ fetchFromGitHub
, stdenv
, mkNode
, nodejs-14_x
, makeWrapper
, lib
, sFetchSrc, drvSrc ? sFetchSrc ./source.json
}:

with (builtins);

mkNode { root = drvSrc; packageLock = ./package-lock.json; nodejs = nodejs-14_x; production = false; } rec {
  pname = "conf-tool";

  nativeBuildInputs = [
    makeWrapper
  ];

  buildPhase = ''
    # BANG="#!${nodejs-14_x}/bin/node"
    # sed "s&oclif-dev manifest&sed 's|^#!.*|$BANG|g' -i node_modules/.bin/oclif-dev ; cd node_modules/@oclif/dev-cli ; oclif-dev manifest&g" -i package.json
    # export HOME=/tmp
    # export DEBUG=*
    sed "s|oclif-dev|true|g" -i package.json
  '';

  installPhase = ''
    wrapProgram "$out/bin/conf" \
      --suffix PATH : "/run/current-system/sw/bin" # to get access to the nixos-* tools
  '';

  meta = with lib; {
    description = "Tool to manage the nixOS config";
    homepage = https://github.com/ssd-solar/conf-tool;
    license = licenses.mpl20;
    maintainers = with maintainers; [ mkg20001 ];
  };
}

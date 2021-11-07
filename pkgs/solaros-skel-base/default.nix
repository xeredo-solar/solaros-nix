{ stdenv
, fetchurl
}:

stdenv.mkDerivation rec {
  pname = "solaros-skel-base";
  version = "0.0.1";

  bashSrc = fetchurl {
    url = "mirror://debian/pool/main/b/bash/bash_5.0-6.debian.tar.xz";
    sha256 = "10lpnd5yw2ixn7ifaa9zysy4pjj4mklsbrasc0rii51ir8p9akd8";
  };

  src = ./.;

  installPhase = ''
    tar xvf $bashSrc --xz
    mkdir -p $out

    sed "s|/usr/bin|/run/current-system/sw/bin|g" -i debian/skel.*

    mkdir $out/.bash.d

    # TODO: check if we can integrate the .bashrc stub into bash itself (consider cross-distro compat, having the stub works everywhere)

    mv debian/skel.bash_logout $out/.bash_logout
    mv debian/skel.bashrc $out/.bash.d/default-bashrc
    mv debian/skel.profile $out/.profile

    for f in files/*; do
      mv $f $out/$(basename $f)
    done
  '';
}

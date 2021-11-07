{ stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "flat-remix-gtk";
  version = "20200718";

  src = fetchFromGitHub {
    owner = "daniruiz";
    repo = pname;
    rev = version;
    sha256 = "04hv8b512ldjrn4gigna24gdf3finm7j98995npm7lyhnfc4smgf";
  };

  dontBuild = true;

  makeFlags = [ "PREFIX=$(out)" ];

  meta = with stdenv.lib; {
    inherit (src.meta) homepage;
    description = "GTK application theme inspired by material design";
    license = licenses.gpl3;
    platforms = platforms.all;
    maintainers = [ maintainers.mkg20001 ];
  };
}

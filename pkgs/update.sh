#!/bin/bash

if [ -z "$1" ]; then
  repos="distinst conf-tool" # nixinstall
else
  repos="$*"
fi

set -euo pipefail

raw_file() {
  wget "https://github.com/ssd-solar/$1/raw/master/$2" -O "$3"
}

set -x

for repo in $repos; do
  rm -rf "$repo"
  mkdir "$repo"

  nix-prefetch-github ssd-solar "$repo" > "$repo/source.json"

  raw_file "$repo" "package.nix" "$repo/default.nix"
  for file in $(cat "$repo/default.nix" | grep -o " \\./[a-z0-9/._-]*" | grep -v "\\./\\."); do
    fpath=${file/"./"/""}
    raw_file "$repo" "$fpath" "$repo/$fpath"
  done
  sed "s|drvSrc \\? .*|sFetchSrc, drvSrc ? sFetchSrc ./source.json|g" -i "$repo/default.nix"
done

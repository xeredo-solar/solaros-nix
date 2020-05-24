#!/bin/bash

if [ -z "$1" ]; then
  repos="nixinstall conf-tool"
else
  repos="$*"
fi

raw_file() {
  wget "https://github.com/ssd-solar/$1/raw/master/$2" -O "$3"
}

for repo in $repos; do
  if [ ! -d "$repo" ]; then
    mkdir "$repo"
    cat template.nix | sed "s|NAME|$repo|g" > "$repo/default.nix"
  fi
  nix-prefetch-git "https://github.com/ssd-solar/$repo" > "$repo/source.json"
  if [ -e "$repo/package-lock.json" ]; then
    raw_file "$repo" "package-lock.json" "$repo/package-lock.json"
  fi
  if [ -e "$repo/app-package-lock.json" ]; then
    raw_file "$repo" "app/package-lock.json" "$repo/app-package-lock.json"
  fi
done

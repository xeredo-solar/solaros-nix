#!/bin/sh

if [ -z "$LOGFILE" ]; then
  LOGFILE="$PWD/installer.log"
fi

set -euo pipefail

touch "$LOGFILE"

# pipe 1,2 to logfile then flip 3 to 2

DUMP_JSON=1 nixos-install "$@" \
  3>&2 \
  2> >(tee >(awk '{ system(""); print strftime("%m.%d.%Y %H:%M:%S %z:"), "stderr:", $0; system(""); }' >> "$LOGFILE") >&1) \
  1> >(tee >(awk '{ system(""); print strftime("%m.%d.%Y %H:%M:%S %z:"), "stdout:", $0; system(""); }' >> "$LOGFILE") >&1) \

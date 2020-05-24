#!/bin/bash

set -e

export PATH="/run/current-system/sw/bin:$PATH"

if [ -z "$1" ]; then
  DEV="/dev/sda"
else
  DEV="$1"
fi

exec sudo -E distinst \
    -h "solaros-testing" \
    -k "us" \
    -l "en_US.UTF-8" \
    -b "$1" \
    -t "$1:gpt" \
    -n "$1:primary:start:512M:fat32:mount=/boot/efi:flags=esp" \
    -n "$1:primary:512M:-4096M:ext4:mount=/" \
    -n "$1:primary:-4096M:end:swap" \
    --username "solaros" \
    --realname "SolarOS User" \
    --tz "Etc/UTC"

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./cinnamon
    ./mate
    ./xfce
  ];
}

{ config, lib, pkgs, ... }:

with lib;

{
  imports = [
    ./../.
  ];

  users.users.solaros = {
    createHome = true;
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    password = "";
  };

  users.users.root.password = "";

  solar.bundle-preload = true;

  services.getty.autologinUser = "root";

  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
    extraConfig = ''
      PermitEmptyPasswords yes
    '';
  };

  # Use good amount of memory
  virtualisation.memorySize = lib.mkDefault 2048;

  # nopasswd
  security.sudo.wheelNeedsPassword = false;

  # Forward ssh, the like
  virtualisation.qemu.networkingOptions = [
    "-net nic,netdev=user.0,model=virtio"
    "-netdev user,id=user.0\${QEMU_NET_OPTS:+,$QEMU_NET_OPTS},hostfwd=tcp::8088-:80,hostfwd=tcp::2222-:22"
    "-soundhw hda"
    "-enable-kvm"
    "-cpu max"
    "-smp 4"
  ];

  # speed boost
  nix.maxJobs = lib.mkDefault 6;
}

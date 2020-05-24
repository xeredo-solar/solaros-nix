# Hacking

So you want to hack on solarOS?

Then you're just at the rigth place

# Pre-requesites

Machine that has nix installed

## Install nix

```
curl https://nixos.org/nix/install | sh
```

## Switch to unstable channel

```
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
```

## Enable the solar cache

```
nix-env -iA cachix -f https://cachix.org/api/v1/install
cachix use solar
```

# Make targets

There are mutliple make targets that save you from typing all the commands yourself

- `start-vm-DE`
- `build-iso-DE`
- `start-iso-DE`

Replace `DE` with either `xfce`, `mate` or `cinnamon`.

So to start a cinnamon vm, do `make start-vm-cinnamon`

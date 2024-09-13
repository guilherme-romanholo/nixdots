### TODO:

- System and Home folder with modules bundles
- Hosts folder with machines (config, vars, hardware)

### Install:

- sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko path/to/disko.nix
- sudo nixos-generate-config --show-hardware-config --no-filesystems --root /mnt > hosts/${hostname}/hardware-configuration.nix
- sudo nixos-install --root /mnt --flake .#hostname

OBS: Disko mode mount not erase the disk

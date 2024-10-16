### TODO:

- Make like jordanisaacs/dotfiles with defaultConfig and hostConfig to pass in the myLib.mkHost
- Hosts folder with machines (config, users, hardware)
- notusknot/dotfiles-nix and mitchellh/nixos-config

### Install:

- sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko path/to/disko.nix
- sudo nixos-generate-config --show-hardware-config --no-filesystems --root /mnt > hosts/${hostname}/hardware-configuration.nix
- sudo nixos-install --root /mnt --flake .#hostname

OBS: Disko mode mount not erase the disk

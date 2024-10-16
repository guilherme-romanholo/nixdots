### TODO:

- Colocar as configurações base dentro do mkHost, passando como argumento local, timezone, etc ...
- Colocar um argumento para a configuração que será importada da pasta hosts (específica)
- Colocar um argumento isWsl para ligar ou desligar o bootloader (default false)
- Colocar um argumento para os usuários que serão utilizados pelo mkUser (pensar melhor sobre HM)

### Install:

- sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko path/to/disko.nix
- sudo nixos-generate-config --show-hardware-config --no-filesystems --root /mnt > hosts/${hostname}/hardware-configuration.nix
- sudo nixos-install --root /mnt --flake .#hostname

OBS: Disko mode mount not erase the disk

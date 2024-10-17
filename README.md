### TODO:

- [x] Mudar os bundle de módulos, por exemplo fazer um core.enable para habilidar todos
- [x] Colocar as configurações base dentro do mkHost, passando como argumento local, timezone, etc ...
- [x] Colocar um argumento para a configuração que será importada da pasta hosts (específica)
- [x] Colocar um argumento isWsl para ligar ou desligar o bootloader (default false)
- [ ] Colocar um argumento para os usuários que serão utilizados pelo mkUser (pensar melhor sobre HM)
- [ ] Usar um ifGroupExists para reutilizar o usuário em vários hosts
- [ ] Criar uma pasta de users no mesmo estilo de hosts, mas para o home-manager

### Install:

- sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko path/to/disko.nix
- sudo nixos-generate-config --show-hardware-config --no-filesystems --root /mnt > hosts/${hostname}/hardware-configuration.nix
- sudo nixos-install --root /mnt --flake .#hostname

OBS: Disko mode mount not erase the disk

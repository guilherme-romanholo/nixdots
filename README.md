### TODO:

- [x] Mudar os bundle de módulos, por exemplo fazer um core.enable para habilidar todos
- [x] Colocar as configurações base dentro do mkHost, passando como argumento local, timezone, etc ...
- [x] Colocar um argumento para a configuração que será importada da pasta hosts (específica)
- [x] Colocar um argumento isWsl para ligar ou desligar o bootloader (default false)
- [X] Criar uma pasta de users no mesmo estilo de hosts, mas para o home-manager
- [ ] Remover os imports do lib
- [ ] No overlays fazer como na config anterior, mas no default colocar o nixpkgs com os overlays e allowUnfree
- [ ] Verificar nas configuraçãoes do Redyf para colocar na minha lib
- [ ] Fazer uma pasta de temas para incluir no host (mkTheme)
- [ ] Fazer um include de modulos (inclusive home-manager) opcional
- [ ] Fazer um mkHM para gerenciar apenas o home manager fora do host
- [ ] Fazer um utils na minha lib
- [ ] Imports e home state em um só {}
- [ ] Fazer um AGS para trocar temas
- [ ] Waybar lateral com degrade de cores
- [ ] Minha config do nixvim

### Install:

- sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko path/to/disko.nix
- sudo nixos-generate-config --show-hardware-config --no-filesystems --root /mnt > hosts/${hostname}/hardware-configuration.nix
- sudo nixos-install --root /mnt --flake .#hostname

OBS: Disko mode mount not erase the disk

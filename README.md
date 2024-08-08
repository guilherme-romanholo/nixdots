# NixOS Dotfiles

### How to add a host
- `cd hosts/`
- `mkdir ${your-hostname}`
- `cp volt/default.nix ${your-hostname}/default.nix`
- `sudo nixos-generate-config --show-hardware-config > ${your-hostname}/hardware-configuration.nix`
- Add your new host in `hosts/default.nix` list
- Edit `${your-hostname}/default.nix` with your settings

### How to rebuild
- Use custom script `rebuild`
- `rebuild switch all`: Rebuild nixos and home-manager
- `rebuild switch home`: Rebuild home-manager
- `rebuild switch system`: Rebuild nixos
- `rebuild boot system`: Rebuild nixos after boot

### How to change theme


### Todo:

- Add stylix in system to test cursor theme
- Make a theme configuration to include in profiles

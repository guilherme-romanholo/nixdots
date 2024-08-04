{
  outputs,
  host,
  pkgs,
  ...
}: {
  imports = [
    ../general/configuration.nix
    outputs.nixosModules.desktop
    outputs.nixosModules.optional
  ];

  desktop = {
    # Enable desktop features like xserver and sddm
    enable = true;
    # Set the keybord
    xserver.layout = host.kblayout;
    # Enable bspwm
    bspwm.enable = true;
    # Enable hyprland
    hyprland.enable = true;
  };

  optional = {
    # Enable docker module
    docker.enable = true;
    # Enable libvirt module
    libvirt.enable = true;
    # Enable printer module
    printer = {
      enable = true;
      drivers = [pkgs.gutenprint];
    };
  };
}

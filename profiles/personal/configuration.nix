{
  outputs,
  host,
  ...
}: {
  imports = [
    ../general/configuration.nix
    outputs.nixosModules.desktop
  ];

  desktop = {
    # Enable desktop features like xserver and sddm
    enable = true;
    # Set the keybord
    xserver.layout = host.kblayout;
    # Enable Hyprland
    hyprland.enable = true;
  };
}

{
  outputs,
  host,
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
  };

  optional = {
    # Enable Openssh module
    openssh.enable = true;
  };
}

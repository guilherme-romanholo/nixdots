{
  inputs,
  outputs,
  host,
  ...
}: {
  imports = [
    # Modules
    ../common
    outputs.nixosModules.desktop
    outputs.nixosModules.optional

    # Hardware
    ./disko.nix
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
  ];

  # Optional
  optional = {
    docker.enable = true;
    libvirt.enable = true;
    openssh.enable = true;
  };

  # Desktop
  desktop = {
    xserver = {
      enable = true;
      layout = host.kblayout;
    };

    sway.enable = true;
    sddm.enable = true;
  };
}

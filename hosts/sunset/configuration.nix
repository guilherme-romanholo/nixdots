{
  inputs,
  outputs,
  pkgs,
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

  # Specific core
  core = {
    bootloader = {
      OSProber = true;
    };
  };

  # Optional
  optional = {
    printer = {
      enable = true;
      drivers = [pkgs.gutenprint];
    };

    docker.enable = true;
    libvirt.enable = true;
  };

  # Desktop
  desktop = {
    xserver = {
      enable = true;
      layout = host.kblayout;
    };

    sddm = {
      enable = true;
      theme = "${pkgs.sddm-astronaut-theme}";
    };

    sway.enable = true;
  };
}

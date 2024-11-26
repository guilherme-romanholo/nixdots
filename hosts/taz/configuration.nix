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

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
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

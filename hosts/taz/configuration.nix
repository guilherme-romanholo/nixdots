{
  inputs,
  outputs,
  host,
  ...
}: {
  imports = [
    # Modules
    outputs.nixosModules.core
    outputs.nixosModules.desktop
    outputs.nixosModules.optional

    # Hardware
    ./disko.nix
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
  ];

  # Core
  core = {
    localtime = {
      enable = true;
      locale = "pt_BR.UTF-8";
      consoleKeymap = "br-abnt2";
      timezone = "America/Sao_Paulo";
    };

    video = {
      enable = true;
      driver = "";
    };

    network = {
      enable = true;
      hostname = host.hostname;
    };

    user = {
      enable = true;
      users = host.users;
    };

    nix.enable = true;
    sound.enable = true;
    bootloader.enable = true;
  };

  # Optional
  optional = {
    hm = {
      enable = true;
      hostAttrs = host;
      homeConfig = ../../suites;
    };

    docker.enable = true;
    libvirt.enable = true;
    openssh.enable = true;
  };

  # Desktop
  desktop = {
    xserver = {
      enable = true;
      layout = "br";
    };

    sway.enable = true;
    sddm.enable = true;
  };

  system.stateVersion = host.stateVersion;
}

{
  inputs,
  outputs,
  pkgs,
  ...
}: let
  vars = import ./default.nix;
in {
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
      driver = "amdgpu";
    };

    network = {
      enable = true;
      hostname = vars.hostname;
    };

    user = {
      enable = true;
      users = vars.users;
    };

    bootloader = {
      enable = true;
      OSProber = true;
    };

    nix.enable = true;
    sound.enable = true;
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
      layout = "br";
    };

    sway.enable = true;
    sddm.enable = true;
  };

  system.stateVersion = vars.stateVersion;
}

{
  inputs,
  outputs,
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

  ############
  # Optional #
  ############

  optional = {
    docker.enable = true;
    libvirt.enable = true;
    openssh.enable = true;
  };

  ###########
  # Desktop #
  ###########

  desktop = {
    xserver = {
      enable = true;
      layout = "br";
    };

    sway.enable = true;
    sddm.enable = true;
  };

  ########
  # Core #
  ########

  core = {
    # Config video
    video = {
      enable = true;
      driver = "";
    };
    # Config timezone
    localtime = {
      enable = true;
      locale = "pt_BR.UTF-8";
      consoleKeymap = "br-abnt2";
      timezone = "America/Sao_Paulo";
    };
    # Config nix
    nix.enable = true;
    # Config network
    network = {
      enable = true;
      hostname = vars.hostname;
    };
    # Bootloader
    bootloader = {
      enable = true;
      OSProber = true;
    };
    # Config sound
    sound.enable = true;
    # Config Users
    user = {
      enable = true;
      users = vars.users;
    };
  };

  system.stateVersion = vars.stateVersion;
}

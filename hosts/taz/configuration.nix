{
  inputs,
  outputs,
  ...
}: let
  vars = import ./default.nix;
  host = vars;
  user = builtins.head vars.users;
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

    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users.guilherme = import ../../suites {inherit outputs host user;};
  };

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
      hostname = vars.hostname;
    };

    user = {
      enable = true;
      users = vars.users;
    };

    nix.enable = true;
    sound.enable = true;
    bootloader.enable = true;
  };

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
      layout = "br";
    };

    sway.enable = true;
    sddm.enable = true;
  };

  system.stateVersion = vars.stateVersion;
}

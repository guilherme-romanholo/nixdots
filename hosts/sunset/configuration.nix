{
  inputs,
  outputs,
  pkgs,
  ...
}: let
  vars = import ./default.nix;
in  {
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
    printer = {
      enable = true;
      drivers = [ pkgs.gutenprint ];
    };

    docker.enable = true;
    libvirt.enable = true;
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
      driver = "amdgpu";
    };
    # Config timezone
    localtime = {
      enable = true;
      locale = "pt_BR.UTF-8";
      consoleKeymap = "br-abnt2";
      timezone = "America/Sao_Paulo";
    };
    # Config nix
    nix = {
      enable = true;
      substituters = ["https://devenv.cachix.org"];
      trustedKeys = ["devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="];
    };
    # Config network
    network = {
      enable = true;
      hostname = vars.hostname;
    };
    # Bootloader
    bootloader.enable = true;
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

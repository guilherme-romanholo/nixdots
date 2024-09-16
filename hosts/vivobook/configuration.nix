{outputs, ...}: let
  vars = import ./default.nix;
in {
  imports = [
    # Modules
    outputs.nixosModules.core
    outputs.nixosModules.desktop
    outputs.nixosModules.optional

    # Hardware
    ./hardware-configuration.nix
  ];

  # Core
  core = {
    localtime = {
      enable = true;
      locale = "pt_BR.UTF-8";
      consoleKeymap = "br-abnt2";
      timezone = "America/Sao_Paulo";
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
  };

  # Optional
  optional = {
    wsl = {
      enable = true;
      defaultUser = (builtins.head vars.users).username;
    };
  };

  system.stateVersion = vars.stateVersion;
}

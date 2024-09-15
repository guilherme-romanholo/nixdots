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
    ./hardware-configuration.nix
  ];

  ############
  # Optional #
  ############

  optional = {
    wsl = {
      enable = true;
      defaultUser = (builtins.head vars.users).username;
    };
  };

  ########
  # Core #
  ########

  core = {
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
    # Config Users
    user = {
      enable = true;
      users = vars.users;
    };
  };

  system.stateVersion = vars.stateVersion;
}

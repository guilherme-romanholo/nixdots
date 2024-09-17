{
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
      hostname = host.hostname;
    };

    user = {
      enable = true;
      users = host.users;
    };

    nix.enable = true;
  };

  # Optional
  optional = {
    wsl = {
      enable = true;
      defaultUser = (builtins.head host.users).username;
    };
  };

  system.stateVersion = host.stateVersion;
}

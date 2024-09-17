{
  outputs,
  host,
  ...
}: {
  imports = [
    # Modules
    outputs.nixosModules.core
  ];

  # Core
  core = {
    localtime = {
      enable = true;
      locale = host.locale;
      consoleKeymap = "${host.kblayout}-abnt2";
      timezone = host.timezone;
    };

    video = {
      enable = true;
      driver = host.videoDriver;
    };

    network = {
      enable = true;
      hostname = host.hostname;
    };

    user = {
      enable = true;
      users = host.users;
    };

    bootloader = {
      enable = true;
    };

    nix.enable = true;
    sound.enable = true;
  };

  system.stateVersion = host.stateVersion;
}

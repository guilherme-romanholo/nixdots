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

    hm = {
      enable = true;
      hostAttrs = host;
      homeConfig = ../../suites;
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

    nix = {
      enable = true;
      substituters = ["https://devenv.cachix.org"];
      trustedKeys = ["devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="];
    };

    sound.enable = true;
  };

  system.stateVersion = host.stateVersion;
}

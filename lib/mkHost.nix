{
  lib,
  inputs,
  ...
}: {
  hostname,
  system,
  locale,
  timezone,
  stateVersion,
  wsl ? false,
  uefi ? false,
  grubDevice ? "",
  users,
  config,
}:
lib.nixosSystem {
  inherit system;
  specialArgs = {inherit inputs;};

  modules = [
    # Host Configs
    config

    # Modules
    ../modules/nixos

    # Base modules config
    {
      networking.hostName = hostname;
      system.stateVersion = stateVersion;

      modules = {
        core.enable = true;

        bootloader = {
          enable =
            if wsl
            then lib.mkDefault false
            else true;
          uefi = uefi;
          device = grubDevice;
        };

        localtime = {
          locale = locale;
          timezone = timezone;
        };

        user.users = users;
      };
    }
  ];
}

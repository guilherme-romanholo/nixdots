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
  config
}:
lib.nixosSystem {
  inherit system;

  specialArgs = {inherit inputs;};
  modules = [
    # Host Settings
    {
      networking.hostName = hostname;
      system.stateVersion = stateVersion;
    }

    # Host Configs
    config

    # Modules
    ../modules/nixos

    {
      modules = {
        # Enable core modules 
        core.enable = true;

        bootloader = {
          device = grubDevice;
          uefi = uefi;
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

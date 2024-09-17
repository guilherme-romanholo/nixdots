{
  outputs,
  host,
  lib,
  ...
}: {
  imports = [
    # Modules
    ../common
    outputs.nixosModules.desktop
    outputs.nixosModules.optional

    # Hardware
    ./hardware-configuration.nix
  ];

  # Core
  core = {
    video.enable = lib.mkDefault false;
    sound.enable = lib.mkDefault false;
    bootloader.enable = lib.mkDefault false;
  };

  # Optional
  optional = {
    wsl = {
      enable = true;
      defaultUser = (builtins.head host.users).username;
    };
  };
}

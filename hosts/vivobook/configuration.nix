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

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
  };

  # Core
  core = {
    video.enable = lib.mkForce false;
    sound.enable = lib.mkForce false;
    bootloader.enable = lib.mkForce false;
  };

  # Optional
  optional = {
    wsl = {
      enable = true;
      defaultUser = (builtins.head host.users).username;
    };
  };
}

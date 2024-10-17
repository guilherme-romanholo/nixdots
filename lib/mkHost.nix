{
  lib,
  inputs,
  ...
}: {
  hostname,
  system,
  stateVersion,
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
    }
  ];
}

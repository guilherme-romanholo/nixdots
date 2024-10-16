{
  lib,
  inputs,
  ...
}: {
  hostname,
  system,
  stateVersion,
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
    ../hosts/${hostname}/configuration.nix
    ../hosts/${hostname}/hardware-configuration.nix

    # Modules
    ../modules
  ];
}

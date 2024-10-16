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
    {
      networking.hostName = hostname;
      system.stateVersion = stateVersion;
    }

    ../hosts/${hostname}/configuration.nix
    ../hosts/${hostname}/hardware-configuration.nix
  ];
}

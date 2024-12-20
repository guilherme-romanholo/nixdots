{
  inputs,
  overlays,
  ...
}: {
  hostname,
  system,
  stateVersion,
  users,
  includeHomeManager ? true,
}: let
  # Import Libs
  lib = import ./. {inherit inputs overlays;};
  # Patched Pkgs
  pkgs = lib.mkPkgs {inherit system;};
in
  lib.nixosSystem {
    inherit pkgs;
    inherit system;
    specialArgs = {inherit inputs lib;};

    modules =
      [
        ../modules/nixos
        ../hosts/${hostname}/configuration.nix

        {
          networking.hostName = hostname;
          system.stateVersion = stateVersion;
          users.users = lib.forUsers users (
            user:
              lib.attrsets.nameValuePair
              user.name (user.config {inherit pkgs;})
          );
        }
      ]
      ++ (
        if includeHomeManager
        then lib.mkHM {inherit users hostname stateVersion;}
        else []
      );
  }

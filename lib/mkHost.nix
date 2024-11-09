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
  pkgs = lib.patchPkgs {inherit system;};
in
  lib.nixosSystem {
    inherit pkgs;
    inherit system;
    specialArgs = {inherit inputs;};

    modules =
      [
        ../modules/nixos
        ../hosts/${hostname}/configuration.nix

        {
          networking.hostName = hostname;
          system.stateVersion = stateVersion;

          users.users = lib.forUsers users (
            user:
              lib.attrsets.nameValuePair user.name
              (lib.mkMerge [user.config {shell = pkgs.${user.shell};}])
          );
        }
      ]
      ++ (
        if includeHomeManager
        then lib.mkHM.module {inherit users hostname stateVersion;}
        else []
      );
  }

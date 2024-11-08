{
  inputs,
  nixpkgs,
  home-manager,
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
  lib = nixpkgs.lib;
  myLib = import ./default.nix {inherit inputs overlays;};
  # Lib Functions
  inherit (myLib) forUsers patchPkgs mkHome;
  # Patched Pkgs
  pkgs = patchPkgs {inherit system;};
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

          users.users = forUsers users (
            user:
              lib.attrsets.nameValuePair user.name
              (lib.mkMerge [user.config {shell = pkgs.${user.shell};}])
          );
        }
      ]
      ++ (
        if includeHomeManager
        then [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users = forUsers users (
              user:
                lib.attrsets.nameValuePair user.name
                (mkHome {
                  username = user.name;
                  inherit hostname;
                  inherit stateVersion;
                })
            );
          }
        ]
        else []
      );
  }

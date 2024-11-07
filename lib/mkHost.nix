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
  # Libs
  inherit (nixpkgs) lib;
  # Make Home
  mkHome = import ./mkHome.nix {inherit overlays;};
  # For Users
  forUsers = users: func: builtins.listToAttrs (map func users);
  # Patched Pkgs
  pkgs = import ./patchPkgs.nix {inherit system nixpkgs overlays;};
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

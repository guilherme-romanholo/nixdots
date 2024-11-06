{
  inputs,
  nixpkgs,
  home-manager,
  patchedPkgs,
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
  # Nixpkgs Pkgs
  pkgs = import nixpkgs {inherit system;};
  # Make Home
  mkHome = import ./mkHome.nix {inherit patchedPkgs;};
  # For Users
  forUsers = users: func: builtins.listToAttrs (map func users);
in
  lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs;};

    modules =
      [
        # Host Specific Configs
        ../modules/nixos
        ../hosts/${hostname}/configuration.nix

        # Add Patched Pkgs
        patchedPkgs

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

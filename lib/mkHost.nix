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
  # Nixpkgs Lib
  inherit (nixpkgs) lib;
  # Home
  mkHome = import ./mkHome.nix {inherit overlays;};
  # Nixpkgs Pkgs
  pkgs = import nixpkgs {inherit system;};
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

        # Add Overlays
        overlays

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
      # Home-manager Configuration
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

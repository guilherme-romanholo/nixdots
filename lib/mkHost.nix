{
  inputs,
  nixpkgs,
  home-manager,
  ...
}: {
  hostname,
  system,
  stateVersion,
  config,
  users,
}: let
  # Nixpkgs Lib
  inherit (nixpkgs) lib;
  # Nixpkgs Pkgs
  pkgs = import nixpkgs {inherit system;};
in
  lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs;};

    modules = [
      # Host Specific Configs
      config

      # Modules
      ../modules/nixos
      home-manager.nixosModules.home-manager

      {
        # Host general configs
        networking.hostName = hostname;
        system.stateVersion = stateVersion;

        # User configs
        users.users = builtins.listToAttrs (map (
            user: {
              name = user.name;
              value = user.system // {shell = pkgs.${user.shell};};
            }
          )
          users);

        # TODO: Add overlays
        nixpkgs = {
          config = {
            allowUnfree = true;
          };
        };

        home-manager = {
          extraSpecialArgs = {inherit inputs;};

          users = builtins.listToAttrs (map (
              user: {
                name = user.name;
                value = user.hm // {home.stateVersion = stateVersion;};
              }
            )
            users);
        };
      }
    ];
  }

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
  # For Users
  forUsers = users: func: builtins.listToAttrs (map func users);
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
        networking.hostName = hostname;
        system.stateVersion = stateVersion;

        # TODO: Add overlays
        nixpkgs = {
          config = {
            allowUnfree = true;
          };
        };

        users.users = forUsers users (user:
          lib.attrsets.nameValuePair user.name 
          (user.system // {shell = pkgs.${user.shell};})
        );

        home-manager.users = forUsers users (user:
          lib.attrsets.nameValuePair user.name
          (user.hm // {home.stateVersion = stateVersion;})
        );
      }
    ];
  }

{
  inputs,
  nixpkgs,
  home-manager,
  ...
}: {
  hostname,
  system,
  stateVersion,
  users,
}: let
  # Nixpkgs Lib
  inherit (nixpkgs) lib;
  # Nixpkgs Pkgs
  pkgs = import nixpkgs {inherit system;};
  # For Users
  forUsers = users: func: builtins.listToAttrs (map func users);
  mapUser = name: value: (lib.attrsets.nameValuePair name (lib.mkMerge value));
in
  lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs;};

    modules = [
      # Host Specific Configs
      ../hosts/${hostname}/configuration.nix

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

        users.users = forUsers users (
          user:
            mapUser
            user.name
            [user.system {shell = pkgs.${user.shell};}]
        );

        home-manager.users = forUsers users (
          user:
            mapUser
            user.name
            [user.hm {imports = [../hosts/${hostname}/home.nix];} {home.stateVersion = stateVersion;}]
        );
      }
    ];
  }

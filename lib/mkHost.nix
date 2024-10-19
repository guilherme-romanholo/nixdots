{
  inputs,
  nixpkgs,
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

    {
      # Host general configs
      networking.hostName = hostname;
      system.stateVersion = stateVersion;

      # User configs
      users.users = builtins.listToAttrs (map (
        user: {
          name = user.name;
          value = {
            isNormalUser = true;
            # TODO: If groups exists
            extraGroups = user.groups;

            shell = pkgs.${user.shell};
            ignoreShellProgramCheck = true;

            initialPassword = "password";
            openssh.authorizedKeys.keys = user.authKeys;
          };
        })
      users);
    }
  ];
}

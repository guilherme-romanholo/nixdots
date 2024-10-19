{
  lib,
  inputs,
  ...
}: {
  hostname,
  system,
  stateVersion,
  config,
  users,
}:
lib.nixosSystem {
  inherit system;
  specialArgs = {inherit inputs;};

  modules = [
    # Host Configs
    config

    {
      users.users = builtins.listToAttrs users;
    }

    # Modules
    ../modules/nixos

    # Base modules config
    {
      networking.hostName = hostname;
      system.stateVersion = stateVersion;
    }
  ];
}

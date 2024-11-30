{
  inputs,
  overlays,
  ...
}: {
  users,
  hostname,
  stateVersion,
}: let
  lib = import ./. {inherit inputs overlays;};
in [
  inputs.home-manager.nixosModules.home-manager
  {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    home-manager.users = lib.forUsers users (
      user:
        lib.attrsets.nameValuePair
        user.name (user.home {inherit hostname stateVersion;})
    );
  }
]

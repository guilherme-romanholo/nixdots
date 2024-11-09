{
  inputs,
  overlays,
  ...
}: let
  lib = import ./. {inherit inputs overlays;};
in {
  module = {
    users,
    hostname,
    stateVersion,
  }: [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users = lib.forUsers users (
        user:
          lib.attrsets.nameValuePair user.name
          (lib.mkHome {
            username = user.name;
            inherit hostname;
            inherit stateVersion;
          })
      );
    }
  ];
}

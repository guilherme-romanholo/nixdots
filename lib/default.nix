{
  inputs,
  nixpkgs,
  home-manager,
  overlays,
  ...
}: {
  mkHost = import ./mkHost.nix {inherit inputs nixpkgs home-manager overlays;};
  mkHome = import ./mkHome {inherit overlays;};
  mkUser = import ./mkUser.nix;
}

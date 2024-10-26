{
  inputs,
  nixpkgs,
  home-manager,
  overlays,
  ...
}: {
  mkHost = import ./mkHost.nix {inherit inputs nixpkgs home-manager overlays;};
  mkUser = import ./mkUser.nix;
}

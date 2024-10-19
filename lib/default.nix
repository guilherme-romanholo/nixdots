{
  inputs,
  nixpkgs,
  home-manager,
  ...
}: {
  mkHost = import ./mkHost.nix {inherit inputs nixpkgs home-manager;};
  mkUser = import ./mkUser.nix;
}

{
  inputs,
  nixpkgs,
  ...
}: {
  mkHost = import ./mkHost.nix {inherit inputs nixpkgs;};
  mkUser = import ./mkUser.nix;
}

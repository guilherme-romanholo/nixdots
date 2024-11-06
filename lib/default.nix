{
  inputs,
  nixpkgs,
  home-manager,
  patchedPkgs,
  ...
}: let
  inherit (nixpkgs) lib;
in {
  # Make Functions
  mkUser = import ./mkUser.nix;
  mkHome = import ./mkHome.nix {inherit patchedPkgs;};
  mkNvim = import ./mkNvim.nix {inherit nixpkgs inputs;};
  mkHost = import ./mkHost.nix {inherit inputs nixpkgs home-manager patchedPkgs;};
  # For
  forAllSystems = lib.genAttrs lib.systems.flakeExposed;
}

{
  inputs,
  nixpkgs,
  home-manager,
  overlays,
  ...
}: let
  inherit (nixpkgs) lib;
in {
  # Make Functions
  mkUser = import ./mkUser.nix;
  mkHome = import ./mkHome {inherit overlays;};
  mkHost = import ./mkHost.nix {inherit inputs nixpkgs home-manager overlays;};
  # For
  forAllSystems = lib.genAttrs lib.systems.flakeExposed;
}

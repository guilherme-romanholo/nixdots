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
  mkHome = import ./mkHome.nix {inherit overlays;};
  mkNvim = import ./mkNvim.nix {inherit nixpkgs inputs;};
  mkHost = import ./mkHost.nix {inherit inputs nixpkgs home-manager overlays;};
  # For
  forAllSystems = lib.genAttrs lib.systems.flakeExposed;
}

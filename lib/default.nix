{
  inputs,
  overlays,
  ...
}: let
  # Lib
  inherit (nixpkgs) lib;
  # inputs
  inherit (inputs) nixpkgs home-manager;
in {
  # Make Functions
  mkUser = import ./mkUser.nix;
  mkHome = import ./mkHome.nix;
  mkNvim = import ./mkNvim.nix {inherit nixpkgs inputs;};
  mkHost = import ./mkHost.nix {inherit inputs nixpkgs home-manager overlays;};

  # For
  forAllSystems = lib.genAttrs lib.systems.flakeExposed;
  forUsers = users: func: builtins.listToAttrs (map func users);

  # Packages
  patchPkgs = import ./patchPkgs.nix {inherit nixpkgs overlays;};
}

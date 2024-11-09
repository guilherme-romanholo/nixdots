{
  inputs,
  overlays,
  ...
}: let
  # inputs
  inherit (inputs) nixpkgs;
  # Lib
  inherit (nixpkgs) lib;
in
  lib
  // {
    # Make Functions
    mkUser = import ./mkUser.nix;
    mkHome = import ./mkHome.nix;
    mkHM = import ./mkHM.nix {inherit inputs overlays;};
    mkNvim = import ./mkNvim.nix {inherit nixpkgs inputs;};
    mkHost = import ./mkHost.nix {inherit inputs overlays;};

    # Pkgs
    patchPkgs = import ./patchPkgs.nix {inherit nixpkgs overlays;};

    # Utils
    forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    forUsers = users: func: builtins.listToAttrs (map func users);
  }

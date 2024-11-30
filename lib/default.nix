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
    mkNvim = import ./mkNvim.nix {inherit nixpkgs inputs;};
    mkHost = import ./mkHost.nix {inherit inputs overlays;};
    mkPkgs = import ./mkPkgs.nix {inherit nixpkgs overlays;};

    # Utils
    forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    forUsers = users: func: builtins.listToAttrs (map func users);
  }

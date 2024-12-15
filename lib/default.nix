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
    mkHM = import ./mkHM.nix {inherit inputs overlays;};
    mkNvim = import ./mkNvim.nix {inherit nixpkgs inputs;};
    mkHost = import ./mkHost.nix {inherit inputs overlays;};
    mkPkgs = import ./mkPkgs.nix {inherit nixpkgs overlays;};
    mkUser = dir:
      builtins.listToAttrs (builtins.map (name: {
        name = name;
        value = import ./mkUser.nix (import ((builtins.toString dir) + "/" + name));
      }) (builtins.attrNames (builtins.readDir dir)));

    # Utils
    forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    forUsers = users: func: builtins.listToAttrs (map func users);
  }

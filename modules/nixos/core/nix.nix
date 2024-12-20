{
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.core.nix;
in {
  options.modules.core.nix = with types; {
    enable = mkEnableOption "Nix";
    substituters = mkOpt (listOf str) [];
    trustedKeys = mkOpt (listOf str) [];
  };

  config = mkIf cfg.enable {
    nix = let
      flakeInputs = filterAttrs (_: isType "flake") inputs;
    in {
      settings = {
        experimental-features = "nix-command flakes";
        auto-optimise-store = true;
        flake-registry = "";
        substituters = cfg.substituters;
        trusted-public-keys = cfg.trustedKeys;
      };

      optimise.automatic = true;

      # Disable nix channels
      channel.enable = false;

      # Configure nix garbage collector
      gc = {
        automatic = true;
        randomizedDelaySec = "24h";
        options = "--delete-older-than 3d";
      };

      # Add each flake input as a registry
      # To make nix3 commands consistent with the flake
      registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;

      # Add nixpkgs input to NIX_PATH
      # This lets nix2 commands still use <nixpkgs>
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };
  };
}

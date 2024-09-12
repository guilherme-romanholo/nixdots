{
  inputs,
  outputs,
  lib,
  config,
  ...
}: let
  cfg = config.core.nix;
in {
  options.core.nix = {
    enable = lib.mkEnableOption "Enable Nix";

    substituters = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Trusted Substituters";
    };

    trustedKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Trusted Substituters Keys";
    };
  };

  config = lib.mkIf cfg.enable {
    # Nixpkgs for global system
    nixpkgs = {
      overlays = [
        outputs.overlays.additions
        outputs.overlays.modifications
        outputs.overlays.unstable-packages
      ];

      config = {
        allowUnfree = true;
      };
    };

    # Nix system configurations
    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
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

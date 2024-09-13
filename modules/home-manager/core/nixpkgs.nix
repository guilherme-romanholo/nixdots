{
  outputs,
  lib,
  config,
  ...
}: let
  cfg = config.core.nixpkgs;
in {
  options.core.nixpkgs = {
    enable = lib.mkEnableOption "Enable Nix Home Configs";
  };

  config = lib.mkIf cfg.enable {
    # Nixpkgs for home system
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
  };
}

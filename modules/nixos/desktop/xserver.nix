{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.desktop.xserver;
in {
  options.desktop.xserver = {
    enable = lib.mkEnableOption "Enable Xserver";

    layout = lib.mkOption {
      type = lib.types.str;
      default = "us";
      description = "Xkb layout";
    };

    variant = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Xkb variant";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable X11.
    services.xserver = {
      enable = true;
      xkb = {
        layout = cfg.layout;
        variant = cfg.variant;
      };
      excludePackages = [pkgs.xterm];
    };
  };
}

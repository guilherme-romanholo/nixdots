{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.xserver;
in {
  options.modules.xserver = {
    enable = lib.mkEnableOption "Xserver";

    layout = lib.mkOption {
      type = lib.types.str;
      default = "br";
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

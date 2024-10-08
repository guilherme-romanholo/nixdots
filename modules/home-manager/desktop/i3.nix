{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.desktop.i3;
in {
  options.desktop.i3 = {
    enable = lib.mkEnableOption "Enable i3 Conf";

    modKey = lib.mkOption {
      type = lib.types.str;
      description = "i3 Modifier";
      default = "Mod4";
    };
  };

  config = lib.mkIf cfg.enable {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        modifier = cfg.modKey;
        terminal = "kitty";
        gaps = {
          inner = 10;
          outer = 5;
        };
      };
    };
  };
}

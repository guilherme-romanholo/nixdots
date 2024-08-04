{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.desktop.bspwm.bspwmrc;
in {
  options.desktop.bspwm.bspwmrc = {
    enable = lib.mkEnableOption "Enable Desktop Bspwmrc";
  };

  config = lib.mkIf cfg.enable {
    xsession.windowManager.bspwm = {
      enable = true;
      settings = {
	border_width = 2;
      };
      startupPrograms = [
	"polybar"
      ];
    };
  };
}

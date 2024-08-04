{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.desktop.bspwm.sxhkd;
in {
  options.desktop.bspwm.sxhkd = {
    enable = lib.mkEnableOption "Enable Desktop Sxhkd";
  };

  config = lib.mkIf cfg.enable {
    services.sxhkd = {
      enable = true;
      keybindings = {
	"super + return" = "${pkgs.kitty}/bin/kitty";
      };
    };
  };
}

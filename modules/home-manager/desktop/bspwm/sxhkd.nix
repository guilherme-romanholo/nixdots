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
	### Applications ###

	# Terminal 
	"super + Return" = "${pkgs.kitty}/bin/kitty";

	### Bspwm Hotkeys ###

	# Quit and restart bspwm
	"super + ctrl + {q,r}" = "${pkgs.bspwm}/bin/bspc {quit,wm -r}";
	# Close and kill
	"super + {_,shift + }q" = "${pkgs.bspwm}/bin/bspc node -{c,k}";
      };
    };
  };
}

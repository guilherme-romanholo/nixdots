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
	# Applications
	"super + Return" = "${pkgs.kitty}/bin/kitty";
	# Bspwm Hotkeys
	"super + ctrl + {q,r}" = "${pkgs.bspwm}/bin/bspc {quit,wm -r}";
	"super + {_,shift + }q" = "${pkgs.bspwm}/bin/bspc node -{c,k}";
	"super + {_,shift + }{1-9,0}" = "${pkgs.bspwm}/bin/bspc {desktop -f, node -d} '^{1-9,10}' --follow";
	# State
	"super + m" = "${pkgs.bspwm}/bin/bspc desktop -l next";
	"super + {t,shift + t,s,f}" = "${pkgs.bspwm}/bin/bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
	# Focus
	"super + shift + {h,j,k,l}" = "${pkgs.bspwm}/bin/bspc node -f {west,south,north,east}";
	# Move/resize
	"super + ctrl + {h,j,k,l}" = "${pkgs.bspwm}/bin/bspc node -v {-20 0,0 20,0 -20,20 0}";
	"super + alt + {h,j,k,l}" = "${pkgs.bspwm}/bin/bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";
	"super + alt + shift + {h,j,k,l}" = "${pkgs.bspwm}/bin/bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";
      };
    };
  };
}

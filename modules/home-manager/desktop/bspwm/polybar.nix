{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.bspwm.polybar;
in {
  options.desktop.bspwm.polybar = {
    enable = lib.mkEnableOption "Enable Desktop Polybar";
  };

  config = lib.mkIf cfg.enable {
    services.polybar = {
      enable = true;
      script = "polybar -q top &";
      settings = {
	"bar/top" = {
	  width = "100%";
	  height = "5%";
	  radius = 0;
	  modules-left = "bspwm";
	  modules-center = "date";
	};
	"module/date" = {
	  type = "internal/date";
	  internal = 5;
	  date = "%d.%m.%y";
	  time = "%H:%M";
	  label = "%time% %date%";
	};
	"module/bspwm" = {
	  type = "internal/bspwm";
	  pin-workspaces = true;
	};
      };
    };
  };
}

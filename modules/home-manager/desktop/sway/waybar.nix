{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.sway.waybar;
in {
  imports = [
  ];

  options.desktop.sway.waybar = {
    enable = lib.mkEnableOption "Enable Sway Waybar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      settings = {
	# Main Bar
	mainBar = {
	  # Bar options
	  layer = "top";
	  position = "top";
	  heigth = 25;

	  modules-left = [ 
	    "custom/logo" 
	    "cpu" 
	    "memory" 
	    "sway/workspaces" 
	  ];

	  modules-right = [
	    "tray"
	    "network"
	    "clock"
	    "custom/power" 
	  ];

	  # Modules 
	  "sway/workspaces" = {
	    disable-scroll = true;
	    all-outputs = true;
	  };

	  "custom/logo" = {
	    format = " {icon}  ";
	    format-icons = "";
	  };

	  "cpu" = {
	    interval = 5;
	    format = "{icon}  {usage}%";
	    format-icons = "";
	  };

	  "memory" = {
	    interval = 5;
	    format = "{icon}  {used:0.1f}G";
	    format-icons = "";
	  };

	  "tray" = {
	    spacing = 5;
	  };

	  "network" = {
	    format = "{icon}  {bandwidthTotalBits}";
	    format-icons = "󰈀";
	  };

	  "clock" = {
	    interval = 60;
	    format = "{:%H:%M}";
	  };

	  "custom/power" = {
	    format = " {icon}  ";
	    format-icons = "⏻";
	  };
	};
      };
    };
  };
}

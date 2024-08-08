{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.desktop.sway.config;
in {
  imports = [
  ];

  options.desktop.sway.config = {
    enable = lib.mkEnableOption "Enable Sway Conf";

    kblayout = lib.mkOption {
      type = lib.types.str;
      description = "Keybord Layout";
      default = "br";
    };

    modKey = lib.mkOption {
      type = lib.types.str;
      description = "Modifier Key";
      default = "Mod4";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.swayfx;
      xwayland = true;

      checkConfig = false;

      config = {
	modifier = cfg.modKey;

	terminal = "kitty";

	menu = "${pkgs.wofi}/bin/wofi --show drun --allow-images";

	bars = [
	  {command = "${pkgs.waybar}/bin/waybar";}
	];

	gaps = {
	  inner = 6;
	  outer = 4;
	};

	input = {
	  "*" = {
	    xkb_layout = "${cfg.kblayout}";
	  };
	};
      };

      extraConfig = ''
	corner_radius 10

	blur enable
	blur_passes 4
	blur_radius 2

	workspace 1
      '';
    };
  };
}

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

      xwayland = true;

      config = {
	modifier = cfg.modKey;
	terminal = "kitty";
	menu = "${pkgs.wofi}/bin/wofi --show drun";

	bars = [
	  {command = "${pkgs.waybar}/bin/waybar";}
	];
      };

      extraConfig = ''
	input * {
	  xkb_layout "${cfg.kblayout}"
	}
      '';
    };
  };
}

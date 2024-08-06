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
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;

      config = {
	modifier = "Mod4";
	terminal = "kitty";
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

{
  lib,
  config,
  ...
}: let
  cfg = config.modules.waybar;
in {
  imports = [
    ./modules
    ./style
  ];

  options.modules.waybar = {
    enable = lib.mkEnableOption "Waybar";

    target = lib.mkOption {
      type = lib.types.str;
      default = "sway-session.target";
      description = "Inital target";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      systemd = {
        enable = true;
        target = cfg.target;
      };

      settings = {
        mainBar = {
          modules-left = [
            "custom/logo"
            "sway/workspaces"
            "tray"
          ];

          modules-center = [
            "temperature"
            "cpu"
            "memory"
            "disk"
          ];

          modules-right = [
            "pulseaudio"
            "backlight"
            "battery"
            "bluetooth"
            "network"
            "clock"
            "custom/power"
          ];
        };
      };
    };
  };
}

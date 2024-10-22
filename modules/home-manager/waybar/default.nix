{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.waybar;
in {
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
          
          "custom/logo" = {
            format = " {icon} ";
            format-icons = "";
            tooltip = false;
          };

          "sway/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
          };

          "tray" = {
            spacing = 5;
          };

          "temperature" = {
            interval = 10;
            critical-threshold = 80;
            format-critical = "  {temperatureC}°C";
            format = "{icon} {temperatureC}°C";
            hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
            format-icons = ["" "" "" ""];
          };

          "cpu" = {
            interval = 10;
            format = "{icon}  {usage}%";
            format-icons = "";
          };

          "memory" = {
            interval = 10;
            format = "{icon}   {used:0.1f}G";
            format-icons = "";
            tooltip-format = "{percentage}% used";
          };

          "disk" = {
            interval = 10;
            format = "󰋊  {percentage_used}%";
            tooltip-format = "{used} used out of {total}";
          };

          "pulseaudio" = {
            format = "{icon}  {volume}%";
            format-icons = "";
          };

          "backlight" = {
            format = "{icon}";
            format-icons = ["" "" "" "" "" "" "" "" ""];
            tooltip = true;
            tooltip-format = "{percent}%";
          };

          "battery" = {
            format = "{icon}";
            format-charging = "{icon}";
            format-warning = "{capacity}%";
            format-critical = "{capacity}%";
            tooltip = true;
            tooltip-format = "{capacity}%";
            states = {
              warning = 30;
              critical = 15;
            };
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󱟢"];
          };

          "bluetooth" = {
            format = "";
            format-on = "󰂯";
            format-off = "󰂲";
            format-disabled = "󰂲";
            format-connected = "󰂱";
            on-click = "${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";
          };

          "network" = {
            interval = 10;
            format-wifi = "{icon}  {essid}";
            format-ethernet = "󰈀  eth";
            format-disconnected = "  Disconneted";
            format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];
            tooltip-format = "{ifname}";
          };

          "clock" = {
            interval = 60;
            format = "  {:%H:%M}";
            format-alt = "  {:%b %d}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

          "custom/power" = {
            format = " {icon} ";
            format-icons = "⏻";
            tooltip = false;
          };
        };
      };
    };
  };
}

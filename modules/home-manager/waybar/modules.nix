{pkgs, ...}: {
  programs.waybar.settings = {
    mainBar = {
      "custom/power" = {
        format = " {icon} ";
        format-icons = "⏻";
        tooltip = false;
      };

      "pulseaudio" = {
        format = "{icon}  {volume}%";
        format-bluetooth = "{icon}  {volume}%";
        scroll-step = 1;
        format-muted = "{icon} ";
        format-icons = "";
        on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
      };

      "temperature" = {
        interval = 10;
        critical-threshold = 80;
        format-critical = "  {temperatureC}°C";
        format = "{icon} {temperatureC}°C";
        hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
        format-icons = ["" "" "" ""];
      };

      "tray" = {
        spacing = 5;
      };

      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
      };

      "network" = {
        interval = 10;
        format-wifi = "{icon}  {essid}";
        format-ethernet = "󰈀  eth";
        format-disconnected = "  Disconneted";
        format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];
        tooltip-format = "{ifname}";
      };

      "memory" = {
        interval = 10;
        format = "{icon}   {used:0.1f}G";
        format-icons = "";
        tooltip-format = "{percentage}% used";
      };

      "custom/logo" = {
        format = " {icon} ";
        format-icons = "";
        tooltip = false;
      };

      "disk" = {
        interval = 10;
        format = "󰋊  {percentage_used}%";
        tooltip-format = "{used} used out of {total}";
      };

      "cpu" = {
        interval = 10;
        format = "{icon}  {usage}%";
        format-icons = "";
      };

      "clock" = {
        interval = 60;
        format = "  {:%H:%M}";
        format-alt = "  {:%b %d}";
        tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      };

      "bluetooth" = {
        format = "";
        format-on = "󰂯";
        format-off = "󰂲";
        format-disabled = "󰂲";
        format-connected = "󰂱";
        on-click = "${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";
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
    };
  };
}

{
  lib,
  config,
  ...
}: let
  cfg = config.colors.waybar-style;
in {
  options.colors.waybar-style = {
    enable = lib.mkEnableOption "Enable Waybar Style";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = with config.lib.stylix.colors; {
      settings = {
        # Main Bar
        mainBar = {
          # Bar options
          layer = "top";
          position = "top";
          heigth = 26;

          margin-left = 10;
          margin-right = 10;

          spacing = 5;

          modules-left = [
            "custom/logo"
            "cpu"
            "memory"
            "disk"
            "temperature"
          ];

          modules-center = [
            "sway/workspaces"
          ];

          modules-right = [
            "tray"
            "clock"
            "clock#date"
            "pulseaudio"
            "network"
            "custom/power"
          ];

          # Modules
          "sway/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
          };

          "custom/logo" = {
            format = " {icon} ";
            format-icons = "";
            tooltip = false;
          };

          "cpu" = {
            interval = 10;
            format = "<span foreground='#${base0B}'>{icon}</span>   {usage}%";
            format-icons = "";
          };

          "memory" = {
            interval = 10;
            format = "<span foreground='#${base0A}'>{icon}</span>   {used:0.1f}G";
            format-icons = "";
            tooltip-format = "{percentage}% used";
          };

          "disk" = {
            interval = 10;
            format = "<span foreground='#${base0F}'></span>  {percentage_used}%";
            tooltip-format = "{used} used out of {total}";
          };

          "temperature" = {
            interval = 10;
            critical-threshold = 80;
            format-critical = "  {temperatureC}°C";
            format = "{icon} {temperatureC}°C";
            hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
            format-icons = [
              "<span foreground='#${base0E}'></span>"
              "<span foreground='#${base0E}'></span>"
              "<span foreground='#${base0E}'></span>"
              "<span foreground='#${base0E}'></span>"
            ];
          };

          "tray" = {
            spacing = 5;
          };

          "pulseaudio" = {
            format = "<span foreground='#${base09}'>{icon}</span>  {volume}%";
            format-icons = "";
          };

          "network" = {
            interval = 10;
            format-wifi = "<span foreground='#${base0C}'>{icon}</span>  {essid}";
            format-ethernet = "<span foreground='#${base0C}'>󰈀</span>  eth";
            format-disconnected = "<span foreground='#${base0C}'></span>  Disconneted";
            format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];
            tooltip-format = "{ifname}";
          };

          "clock" = {
            interval = 60;
            format = "<span foreground='#${base0D}'>  </span>{:%H:%M}";
            tooltip = false;
          };

          "clock#date" = {
            interval = 60;
            format = "<span foreground='#${base0E}'> </span> {:%b %d}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };

          "custom/power" = {
            format = " {icon} ";
            format-icons = "⏻";
            tooltip = false;
          };
        };
      };

      style = ''
        * {
            padding:0px;
            border-radius: 0px;
            border: none;
            min-height: 0;
            margin: 0px 2px;
        }

        #waybar {
            background-color: #${base00};
            color: #${base05};
            transition-property: background-color;
            transition-duration: 0.5s;
            border-top: 3px transparent;
            border-radius: 0px;
        }

        window#waybar {
            background-color: #${base00};
            border: 0.1em solid #${base03};
            border-top: 0em;
            border-radius: 0px 0px 12px 12px;
        }

        window#waybar.hidden {
          opacity: 0.2;
        }

        #custom-logo,
        #workspaces,
        #cpu,
        #memory,
        #temperature,
        #disk,
        #tray,
        #pulseaudio,
        #network,
        #clock,
        #custom-power {
            background-image: linear-gradient(to right, #${base00}, #${base02});
            border: 0.1em solid #${base03};
            padding: 0.3em 0.35em 0.3em 0.35em;
            margin: 0.4em;
        }

        #custom-logo {
            border-radius: 20px;
            color: #${base0D};
            padding-bottom: 0.2em;
            padding-right: 0.45em;
            padding-left: 0.05em;
        }

        #custom-power {
            border-radius: 20px;
            color: #${base08};
            padding-bottom: 0.2em;
            padding-right: 0.25em;
            padding-left: 0.05em;
        }

        #cpu,
        #memory,
        #temperature,
        #disk {
            border-radius: 14px 0px 14px 0px;
        }

        #tray,
        #pulseaudio,
        #network,
        #clock {
            border-radius: 0px 14px 0px 14px;
        }

        #workspaces {
            border-radius: 0px 0px 14px 14px;
        }

        tooltip {
            border-radius: 12px;
            border: 0.1em solid #${base03};
        }

        tooltip label {
            color: #${base05};
        }
      '';
    };
  };
}

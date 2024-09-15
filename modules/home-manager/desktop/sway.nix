{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.desktop.sway;
in {
  options.desktop.sway = {
    enable = lib.mkEnableOption "Enable Sway Conf";

    kblayout = lib.mkOption {
      type = lib.types.str;
      description = "Keybord Layout";
      default = "br";
    };

    modKey = lib.mkOption {
      type = lib.types.str;
      description = "Sway Modifier";
      default = "Mod4";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.sway = {
      enable = true;
      package = pkgs.swayfx;

      xwayland = true;
      systemd.enable = true;

      checkConfig = false;

      config = {
        modifier = cfg.modKey;

        terminal =
          if config.programs.kitty.enable
          then "kitty"
          else "foot";

        menu = "${pkgs.wofi}/bin/wofi";

        bars = lib.mkIf config.programs.waybar.enable [];

        gaps = {
          inner = 6;
          outer = 4;
        };

        input = {
          "*" = {
            xkb_layout = "${cfg.kblayout}";
          };
        };

        keybindings = lib.mkOptionDefault {
          "${cfg.modKey}+Shift+Return" = "exec ${pkgs.kitty}/bin/kitty --class termfloat";
          "Ctrl+Alt+l" = "exec ${pkgs.swaylock-effects}/bin/swaylock";
          "Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot copy area";
          "Shift+Print" = "exec ${pkgs.sway-contrib.grimshot}/bin/grimshot save area";
        };
      };

      extraConfig = ''
        # Float terminal
        for_window [app_id="termfloat"] {
          floating enable
          resize set width 60ppt height 70ppt
        }

        # Start workspace
        workspace 1

        # Remove title
        default_border pixel

        # SwayFX Config
        corner_radius 10
        blur enable
        blur_passes 4
        blur_radius 2
      '';
    };
  };
}

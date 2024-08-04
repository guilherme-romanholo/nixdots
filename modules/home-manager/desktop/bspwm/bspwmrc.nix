{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.desktop.bspwm.bspwmrc;
in {
  options.desktop.bspwm.bspwmrc = {
    enable = lib.mkEnableOption "Enable Desktop Bspwmrc";
  };

  config = lib.mkIf cfg.enable {
    xsession = {
      enable = true;
      windowManager.bspwm = {
        enable = true;
        settings = {
          border_width = 2;
        };
        startupPrograms = [
          "polybar"
        ];
        extraConfig = ''
          default_workspaces() {
              for monitor in `xrandr -q | grep -w 'connected' | cut -d' ' -f1`; do
          	bspc monitor "$monitor" -d '' '' '' '' '' '' '' ''
              done
                 }

          default_workspaces
        '';
      };
    };
  };
}

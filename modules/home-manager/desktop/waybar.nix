{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.waybar;
in {
  options.desktop.waybar = {
    enable = lib.mkEnableOption "Enable Sway Waybar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      systemd = {
        enable = true;
        target = "sway-session.target";
      };
    };
  };
}

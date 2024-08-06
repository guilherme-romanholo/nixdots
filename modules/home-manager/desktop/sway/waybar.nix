{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.sway.waybar;
in {
  imports = [
  ];

  options.desktop.sway.waybar = {
    enable = lib.mkEnableOption "Enable Sway Waybar";
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;
    };
  };
}

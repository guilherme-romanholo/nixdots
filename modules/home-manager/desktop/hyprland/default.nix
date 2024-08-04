{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.hyprland;
in {
  imports = [
  ];

  options.desktop.hyprland = {
    enable = lib.mkEnableOption "Enable Desktop Hyprland";
  };

  config = lib.mkIf cfg.enable {
  };
}

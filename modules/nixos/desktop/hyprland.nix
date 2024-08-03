{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true;
  };
}

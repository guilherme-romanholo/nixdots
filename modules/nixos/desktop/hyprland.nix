{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.hyprland;
in {
  options.desktop.sddm = {
    enable = lib.mkEnableOption "Enable Hyprland";
  };

  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true;
  };
}

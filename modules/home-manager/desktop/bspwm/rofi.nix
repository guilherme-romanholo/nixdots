{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.bspwm.rofi;
in {
  options.desktop.bspwm.rofi = {
    enable = lib.mkEnableOption "Enable Desktop Rofi";
  };

  config = lib.mkIf cfg.enable {
    programs.rofi = {
      enable = true;
    };
  };
}

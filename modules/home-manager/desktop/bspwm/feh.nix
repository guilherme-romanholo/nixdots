{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.bspwm.feh;
in {
  options.desktop.bspwm.feh = {
    enable = lib.mkEnableOption "Enable Desktop Feh";
  };

  config = lib.mkIf cfg.enable {
    programs.feh = {
      enable = true;
    };
  };
}

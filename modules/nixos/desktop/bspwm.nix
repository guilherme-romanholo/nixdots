{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.bspwm;
in {
  options.desktop.bspwm = {
    enable = lib.mkEnableOption "Enable Bspwm";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.windowManager.bspwm.enable = true;
  };
}

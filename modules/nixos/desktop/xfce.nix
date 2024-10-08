{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.xfce;
in {
  options.desktop.xfce = {
    enable = lib.mkEnableOption "Enable Xfce";
  };

  config = lib.mkIf cfg.enable {
    services.xserver = {
      desktopManager = {
        xterm.enable = false;
        xfce = {
          enable = true;
          noDesktop = true;
          enableXfwm = false;
        };
      };
      windowManager.i3.enable = true;
    };
  };
}

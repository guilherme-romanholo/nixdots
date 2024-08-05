{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.bspwm;
in {
  imports = [
    ./feh.nix
    ./rofi.nix
    ./sxhkd.nix
    ./bspconf.nix
    ./polybar.nix
  ];

  options.desktop.bspwm = {
    enable = lib.mkEnableOption "Enable Desktop Bspwm";
  };

  config = lib.mkIf cfg.enable {
    desktop.bspwm = {
      feh.enable = lib.mkDefault true;
      rofi.enable = lib.mkDefault true;
      sxhkd.enable = lib.mkDefault true;
      bspconf.enable = lib.mkDefault true;
      polybar.enable = lib.mkDefault true;
    };
  };
}

{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.bspwm;
in {
  imports = [
    ./sxhkd.nix
    ./bspwmrc.nix
  ];

  options.desktop.bspwm = {
    enable = lib.mkEnableOption "Enable Desktop Bspwm";
  };

  config = lib.mkIf cfg.enable {
    desktop.bspwm = {
      sxhkd.enable = lib.mkDefault true;
      bspwmrc.enable = lib.mkDefault true;
    };
  };
}

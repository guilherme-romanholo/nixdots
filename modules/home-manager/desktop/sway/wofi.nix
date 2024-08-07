{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.sway.wofi;
in {
  imports = [
  ];

  options.desktop.sway.wofi = {
    enable = lib.mkEnableOption "Enable Sway Wofi";
  };

  config = lib.mkIf cfg.enable {
    programs.wofi = {
      enable = true;
    };
  };
}

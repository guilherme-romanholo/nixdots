{
  lib,
  config,
  ...
}: let
  cfg = config.desktop;
in {
  imports = [
    ./apps
    ./sway
  ];

  options.desktop = {
    enable = lib.mkEnableOption "Enable Desktop Home Modules";
  };

  config = lib.mkIf cfg.enable {
    desktop = {
      apps.enable = lib.mkDefault false;
      sway.enable = lib.mkDefault false;
    };
  };
}

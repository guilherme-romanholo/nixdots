{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.mako;
in {
  options.desktop.mako = {
    enable = lib.mkEnableOption "Enable Mako";
  };

  config = lib.mkIf cfg.enable {
    services.mako = {
      enable = true;

      borderSize = 1;
      borderRadius = 8;

      icons = true;

      width = 300;
      padding = "10";
      maxVisible = 3;

      layer = "overlay";
    };
  };
}

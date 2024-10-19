{
  lib,
  config,
  ...
}: let
  cfg = config.modules.mako;
in {
  options.modules.mako = {
    enable = lib.mkEnableOption "Mako";
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

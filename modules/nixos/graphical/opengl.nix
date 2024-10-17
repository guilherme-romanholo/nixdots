{
  lib,
  config,
  ...
}: let
  cfg = config.modules.opengl;
in {
  options.modules.opengl = {
    enable = lib.mkEnableOption "OpenGL";
  };

  config = lib.mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
    };
  };
}

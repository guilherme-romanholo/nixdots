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
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}

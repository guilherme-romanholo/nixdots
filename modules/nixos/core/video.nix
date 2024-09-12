{
  lib,
  config,
  ...
}: let
  cfg = config.core.video;
in {
  options.core.video = {
    enable = lib.mkEnableOption "Enable Video";

    driver = lib.mkOption {
      type = lib.types.str;
      description = "Video Driver";
    };
  };

  config = lib.mkIf cfg.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    boot.initrd.kernelModules = ["${cfg.driver}"];
  };
}

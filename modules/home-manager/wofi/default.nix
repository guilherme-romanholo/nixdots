{
  lib,
  config,
  ...
}: let
  cfg = config.modules.wofi;
in {
  options.modules.wofi = {
    enable = lib.mkEnableOption "Wofi";
  };

  config = lib.mkIf cfg.enable {
    programs.wofi = {
      enable = true;

      settings = {
        show = "drun";
        location = 0;
        no_actions = true;
        allow_images = true;
      };
    };
  };
}

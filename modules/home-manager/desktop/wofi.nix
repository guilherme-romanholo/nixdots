{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.wofi;
in {
  options.desktop.wofi = {
    enable = lib.mkEnableOption "Enable Sway Wofi";
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

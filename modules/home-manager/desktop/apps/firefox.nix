{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.apps.firefox;
in {
  options.desktop.apps.firefox = {
    enable = lib.mkEnableOption "Enable Firefox";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}

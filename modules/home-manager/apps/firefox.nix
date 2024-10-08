{
  lib,
  config,
  ...
}: let
  cfg = config.apps.firefox;
in {
  options.apps.firefox = {
    enable = lib.mkEnableOption "Enable Firefox";
  };

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
    };
  };
}

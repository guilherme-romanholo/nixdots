{
  lib,
  config,
  ...
}: let
  cfg = config.apps.kitty;
in {
  options.apps.kitty = {
    enable = lib.mkEnableOption "Enable Kitty";
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      settings = {
        enable_audio_bell = false;
        allow_hyperlinks = true;
      };
    };
  };
}

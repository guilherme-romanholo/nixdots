{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.core.localtime;
in {
  options.modules.core.localtime = with types; {
    enable = lib.mkEnableOption "Localtime";
    timezone = mkOpt str "America/Sao_Paulo";
    locale = mkOpt str "pt_BR.UTF-8";
    consoleKeymap = mkOpt str "br-abnt2";
  };

  config = lib.mkIf cfg.enable {
    time.timeZone = cfg.timezone;
    i18n.defaultLocale = cfg.locale;

    i18n.extraLocaleSettings = {
      LANGUAGE = cfg.locale;
      LC_ALL = cfg.locale;
      LC_ADDRESS = cfg.locale;
      LC_IDENTIFICATION = cfg.locale;
      LC_MEASUREMENT = cfg.locale;
      LC_MONETARY = cfg.locale;
      LC_NAME = cfg.locale;
      LC_NUMERIC = cfg.locale;
      LC_PAPER = cfg.locale;
      LC_TELEPHONE = cfg.locale;
      LC_TIME = cfg.locale;
    };

    console.keyMap = cfg.consoleKeymap;
  };
}

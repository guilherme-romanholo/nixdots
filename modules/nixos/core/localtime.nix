{
  lib,
  config,
  ...
}: let
  cfg = config.modules.localtime;
in {
  options.modules.localtime = {
    enable = lib.mkEnableOption "Localtime";

    timezone = lib.mkOption {
      type = lib.types.str;
      default = "America/Sao_Paulo";
      description = "System Timezone";
    };

    locale = lib.mkOption {
      type = lib.types.str;
      default = "pt_BR.UTF-8";
      description = "System locale";
    };

    consoleKeymap = lib.mkOption {
      type = lib.types.str;
      default = "br-abnt2";
      description = "System Console Keymap";
    };
  };

  config = lib.mkIf cfg.enable {
    # Set your time zone.
    time.timeZone = cfg.timezone;

    # Select internationalisation properties.
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

    # Configure console keymap
    console.keyMap = cfg.consoleKeymap;
  };
}

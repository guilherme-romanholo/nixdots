{
  lib,
  config,
  ...
}: let
  cfg = config.core.localtime;
in {
  options.core.localtime = {
    enable = lib.mkEnableOption "Enable Localtime Module";

    timezone = lib.mkOption {
      type = lib.types.str;
      default = "Etc/GMT";
      description = "System Timezone";
    };

    locale = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
      description = "System locale";
    };

    consoleKeymap = lib.mkOption {
      type = lib.types.str;
      default = "us";
      description = "System Console Keymap";
    };
  };

  config = lib.mkIf cfg.enable {
    # Set your time zone.
    time.timeZone = cfg.timezone;

    # Select internationalisation properties.
    i18n.defaultLocale = cfg.locale;

    i18n.extraLocaleSettings = {
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

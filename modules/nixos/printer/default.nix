{
  lib,
  config,
  ...
}: let
  cfg = config.modules.printer;
in {
  options.modules.printer = {
    enable = lib.mkEnableOption "Enable Printer";

    drivers = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Printer Drivers List";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;
    # Printer drivers
    services.printing.drivers = cfg.drivers;
    # Enable printer scanner
    hardware.sane.enable = true;
    # Enable network printer discover
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}

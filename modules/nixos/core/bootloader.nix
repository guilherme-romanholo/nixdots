{
  lib,
  config,
  ...
}: let
  cfg = config.modules.bootloader;
in {
  options.modules.bootloader = {
    enable = lib.mkEnableOption "Bootloader";

    device = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Grub Device";
    };

    OSProber = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable OS Prober";
    };
  };

  config = lib.mkIf cfg.enable {
    # Grub
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;

      device = cfg.device;
      useOSProber = cfg.OSProber;
    };
  };
}

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

    uefi = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Uefi";
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

      efiSupport = cfg.uefi;
      efiInstallAsRemovable = cfg.uefi;

      device = cfg.device;
      useOSProber = cfg.OSProber;
    };
  };
}

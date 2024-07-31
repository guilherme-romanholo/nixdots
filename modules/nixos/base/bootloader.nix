{
  lib,
  config,
  ...
}: let
  cfg = config.base.bootloader;
in {
  options.base.bootloader = {
    enable = lib.mkEnableOption "Enable Bootloader module";

    bootmode = lib.mkOption {
      type = lib.types.str;
      default = "grub";
      description = "Host Bootmode Option (uefi or grub)";
    };

    device = lib.mkOption {
      type = lib.types.str;
      default = "/dev/sda";
      description = "Grub Disk Location";
    };

    OSProber = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable OS Prober";
    };
  };

  config = lib.mkIf cfg.enable {
    # Grub
    boot.loader.grub.enable =
      if (cfg.bootmode == "grub")
      then true
      else false;
    boot.loader.grub.device = cfg.device;
    boot.loader.grub.useOSProber = cfg.OSProber;

    # Uefi
    boot.loader.systemd-boot.enable =
      if (cfg.bootmode == "uefi")
      then true
      else false;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}

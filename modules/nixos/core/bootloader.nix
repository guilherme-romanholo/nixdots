{
  lib,
  config,
  ...
}: let
  cfg = config.modules.bootloader;
in {
  options.modules.bootloader = {
    enable = lib.mkEnableOption "Bootloader";

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
      useOSProber = cfg.OSProber;
    };
  };
}

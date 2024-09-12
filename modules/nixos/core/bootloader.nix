{
  lib,
  config,
  ...
}: let
  cfg = config.core.bootloader;
in {
  options.core.bootloader = {
    enable = lib.mkEnableOption "Enable Bootloader module";

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

{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.core.bootloader;
in {
  options.modules.core.bootloader = with types; {
    enable = mkEnableOption "Bootloader";
    device = mkOpt str "";
    uefi = mkOpt bool false;
    OSProber = mkOpt bool false;
  };

  config = mkIf cfg.enable {
    boot.loader.grub = {
      enable = true;

      efiSupport = cfg.uefi;
      efiInstallAsRemovable = cfg.uefi;

      device = cfg.device;
      useOSProber = cfg.OSProber;
    };
  };
}

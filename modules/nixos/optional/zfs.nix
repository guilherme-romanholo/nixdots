{
  lib,
  config,
  ...
}: let
  cfg = config.optional.zfs;
in {
  options.optional.zfs = {
    enable = lib.mkEnableOption "Enable Zfs Support";
  };

  config = lib.mkIf cfg.enable {
    boot = {
      supportedFilesystems = ["zfs"];

      zfs = {
        forceImportRoot = false;
        extraPools = ["zroot"];
        devNodes = "/dev/disk/by-partlabel";
        # devNodes = "/dev/disk/by-partuuid";
      };

      loader.grub = {
        zfsSupport = true;
        mirroredBoots = [
          {
            devices = ["nodev"];
            path = "/boot";
          }
        ];
      };
    };
  };
}

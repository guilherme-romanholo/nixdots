{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.optional.libvirt;
in {
  options.optional.libvirt = {
    enable = lib.mkEnableOption "Enable Libvirt";
  };

  config = lib.mkIf cfg.enable {
    # Enable dconf
    programs.dconf.enable = true;
    # Necessary packages
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
    ];
    # Virtualization services
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [pkgs.OVMFFull.fd];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}

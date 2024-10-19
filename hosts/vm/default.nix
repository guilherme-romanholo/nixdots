{
  imports = [
    ./hardware.nix
  ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  modules = {
    core.enable = true;

    bootloader = {
      device = "/dev/vda";
    };

    graphical.enable = true;
    openssh.enable = true;
    printer.enable = true;
  };
}

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  modules = {
    # Optional Modules
    graphical.enable = true;
    openssh.enable = true;
    printer.enable = true;
    xserver.layout = "br";
  };
}

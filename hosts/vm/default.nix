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

    localtime = {
      locale = "pt_BR.UTF-8";
      timezone = "America/Sao_Paulo";
    };

    user.users = [
      {
        username = "nixos";
        groups = ["networkmanager" "wheel"];
      }
    ];

    graphical.enable = true;
    xserver.layout = "br";

    openssh.enable = true;
    printer.enable = true;
  };
}

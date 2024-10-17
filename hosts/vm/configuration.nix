{
  modules = {
    core.enable = true;

    # Core Modules
    bootloader = {
      device = "/dev/vda";
    };

    localtime = {
      locale = "pt_BR.UTF-8";
      timezone = "America/Sao_Paulo";
      consoleKeymap = "br-abnt2";
    };

    user = {
      users = [
        {username = "nixos"; groups = ["networkmanager" "wheel"];}
      ];
    };

    # Optional Modules
    graphical.enable = true;

    openssh = {
      enable = true;
    };

    printer = {
      enable = true;
    };

    xserver = {
      layout = "br";
    };
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}

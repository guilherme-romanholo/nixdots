{
  modules = {
    # Core Modules
    bootloader = {
      enable = true;
      device = "/dev/vda";
    };

    network = {
      enable = true;
    };

    sound = {
      enable = true;
    };

    nix = {
      enable = true;
    };

    localtime = {
      locale = "pt_BR.UTF-8";
      timezone = "America/Sao_Paulo";
      consoleKeymap = "br-abnt2";
    };

    user = {
      enable = true;
      users = [
        {username = "nixos"; groups = ["networkmanager" "wheel"];}
      ];
    };

    # Optional Modules
    openssh = {
      enable = true;
    };

    printer = {
      enable = true;
    };

    xserver = {
      enable = true;
    };
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}

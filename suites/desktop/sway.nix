{outputs, host, ...}: {
  imports = [
    outputs.homeManagerModules.desktop
  ];

  desktop = {
    sway = {
      enable = true;
      kblayout = host.kblayout;
    };

    waybar = {
      enable = true;
    };

    wofi = {
      enable = true;
    };

    swaylock = {
      enable = true;
    };

    mako = {
      enable = true;
    };
  };
}

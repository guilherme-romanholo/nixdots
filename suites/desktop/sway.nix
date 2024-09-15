{outputs, ...}: {
  imports = [
    outputs.homeManagerModules.desktop
  ];

  desktop = {
    sway = {
      enable = true;
      kblayout = "br";
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
  };
}

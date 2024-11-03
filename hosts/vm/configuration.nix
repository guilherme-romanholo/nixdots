{
  imports = [
    ./hardware-configuration.nix
  ];

  modules = {
    core.enable = true;

    bootloader = {
      device = "/dev/vda";
    };

    sway.enable = true;
    wayfire.enable = true;
    graphical.enable = true;

    openssh.enable = true;
    printer.enable = true;
  };
}

{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  modules = {
    core.enable = true;

    bootloader = {
      device = "/dev/vda";
    };

    sway.enable = true;
    graphical.enable = true;

    openssh.enable = true;
    printer.enable = true;

    stylix = {
      enable = true;

      wallpaper = ./wallpaper.jpg;
      polarity = "dark";
      colorscheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

      cursorPkg = "bibata-cursors";
      cursorName = "Bibata-Modern-Classic";
    };
  };
}

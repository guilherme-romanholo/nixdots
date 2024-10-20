{pkgs, ...}: {
  modules = {
    sway.enable = true;
    wofi.enable = true;
    waybar.enable = true;
  };

  home.packages = with pkgs; [
    nautilus
  ];

  stylix = {
    enable = true;

    image = ./wallpaper.jpg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  };
}

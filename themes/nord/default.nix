{pkgs}: {
  colorscheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
  polarity = "dark";

  wallpaper = ./nord_warrior.jpg;

  cursorPkg = pkgs.nordzy-cursor-theme;
  cursorName = "Nordzy-cursors";

  iconPkg = pkgs.nordzy-icon-theme;
  iconName = "Nordzy-turquoise-dark";
}

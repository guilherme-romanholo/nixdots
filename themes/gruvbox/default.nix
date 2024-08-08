{pkgs}: {
  colorscheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  polarity = "dark";

  wallpaper = ./gruv_snowcity.jpg;

  cursorPkg = pkgs.capitaine-cursors-themed;
  cursorName = ''"Capitaine Cursors (Gruvbox)"'';

  iconPkg = pkgs.gruvbox-icons-plus;
  iconName = "Gruvbox-Plus-Dark";
}

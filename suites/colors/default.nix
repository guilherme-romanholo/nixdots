let
  theme = import ../../themes;
in {
  colors = {
    stylix = {
      enable = true;

      polarity = theme.polarity;
      wallpaper = theme.wallpaper;
      colorscheme = theme.colorscheme;

      cursorPkg = theme.cursorPkg;
      cursorName = theme.cursorName;
    };

    gtk = {
      enable = true;

      iconPkg = theme.iconPkg;
      iconName = theme.iconName;
    };

    waybar-style.enable = true;
  };
}

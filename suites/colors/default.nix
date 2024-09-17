{ outputs, ... }: {
  colors = {
    stylix = {
      enable = true;

      polarity = outputs.theme.polarity;
      wallpaper = outputs.theme.wallpaper;
      colorscheme = outputs.theme.colorscheme;

      cursorPkg = outputs.theme.cursorPkg;
      cursorName = outputs.theme.cursorName;
    };

    gtk = {
      enable = true;

      iconPkg = outputs.theme.iconPkg;
      iconName = outputs.theme.iconName;
    };

    waybar-style.enable = true;
  };
}

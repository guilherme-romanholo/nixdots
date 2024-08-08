{
  outputs,
  pkgs,
  host,
  ...
}: let
  theme = import ./../../themes {inherit pkgs;};
in {
  imports = [
    ../general/home.nix
    outputs.homeManagerModules.desktop
    outputs.homeManagerModules.optional
  ];

  desktop = {
    # Enable home desktop configurations
    enable = true;
    # Enable desktop home apps
    apps.enable = true;
    # Enable Sway Home
    sway = {
      enable = true;
      config.kblayout = host.kblayout;
    };
  };

  optional = {
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
  };
}

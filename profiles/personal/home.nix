{
  outputs,
  pkgs,
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
    # Enable bspwm home config
    bspwm.enable = true;
    # Enable desktop home apps
    apps.enable = true;
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
  };
}

{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.optional.stylix;
in {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  options.optional.stylix = {
    enable = lib.mkEnableOption "Enable Stylix";

    colorscheme = lib.mkOption {
      type = lib.types.str;
      description = "Stylix Colorscheme";
    };

    polarity = lib.mkOption {
      type = lib.types.str;
      description = "Dark or Light";
    };

    wallpaper = lib.mkOption {
      type = lib.types.path;
      description = "Stylix Wallpaper";
    };

    cursorPkg = lib.mkOption {
      type = lib.types.package;
      description = "Cursor Package";
    };

    cursorName = lib.mkOption {
      type = lib.types.str;
      description = "Cursor Name";
    };

    iconPkg = lib.mkOption {
      type = lib.types.package;
      description = "Icon Package";
    };

    iconName = lib.mkOption {
      type = lib.types.str;
      description = "Icon Name";
    };
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;

      image = cfg.wallpaper;
      polarity = cfg.polarity;
      base16Scheme = cfg.colorscheme;

      cursor = {
        package = cfg.cursorPkg;
        name = cfg.cursorName;
      };

      fonts = {
        monospace = {
          package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
          name = "FiraCode Nerd Font Mono";
        };

        sizes = {
          desktop = 12;
          popups = 10;
          terminal = 11;
          applications = 10;
        };
      };

      opacity = {
	terminal = 0.85;
	applications = 0.9;
      };
    };
  };
}

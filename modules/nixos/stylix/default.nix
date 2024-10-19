{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.stylix;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  options.modules.stylix = {
    enable = lib.mkEnableOption "Stylix";

    colorscheme = lib.mkOption {
      type = lib.types.anything;
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
      type = lib.types.str;
      description = "Cursor Package";
    };

    cursorName = lib.mkOption {
      type = lib.types.str;
      description = "Cursor Name";
    };
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;

      image = cfg.wallpaper;
      polarity = cfg.polarity;
      base16Scheme = cfg.colorscheme;

      cursor = {
        package = pkgs.${cfg.cursorPkg};
        name = cfg.cursorName;
        size = 16;
      };

      fonts = {
        monospace = {
          package = pkgs.nerdfonts.override {fonts = ["FiraCode"];};
          name = "FiraCode Nerd Font Mono";
        };

        sansSerif = {
          package = pkgs.open-sans;
          name = "Open Sans";
        };

        serif = {
          package = pkgs.roboto-serif;
          name = "Roboto Serif";
        };

        sizes = {
          desktop = 11;
          popups = 10;
          terminal = 11;
          applications = 10;
        };
      };

      opacity = {
        terminal = 0.85;
        applications = 0.85;
      };
    };
  };
}

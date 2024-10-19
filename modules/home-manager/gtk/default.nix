{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.gtk;
in {
  options.modules.gtk = {
    enable = lib.mkEnableOption "Gtk";

    iconPkg = lib.mkOption {
      type = lib.types.str;
      description = "Icon Package";
    };

    iconName = lib.mkOption {
      type = lib.types.str;
      description = "Icon Name";
    };
  };

  config = lib.mkIf cfg.enable {
    gtk = {
      iconTheme = {
        package = pkgs.${cfg.iconPkg};
        name = cfg.iconName;
      };
    };
  };
}

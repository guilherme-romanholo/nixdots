{
  config,
  lib,
  ...
}: let
  cfg = config.optional.gtk;
in  {
  options.optional.gtk = {
    enable = lib.mkEnableOption "Enable Gtk";

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
    gtk = {
      iconTheme = {
	package = cfg.iconPkg;
	name = cfg.iconName;
      };
    };
  };
}

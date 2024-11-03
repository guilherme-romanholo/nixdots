{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.wayfire;
in {
  options.modules.wayfire = {
    enable = lib.mkEnableOption "Wayfire";
  };

  config = lib.mkIf cfg.enable {
    # Enable Sway.
    programs.wayfire = {
      enable = true;
      xwayland.enable = true;
    };

    # Security
    services.gnome.gnome-keyring.enable = true;
    security.polkit.enable = true;

    # Dbus
    services.dbus.enable = true;

    # Portals
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
  };
}

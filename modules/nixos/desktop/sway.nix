{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.desktop.sway;
in {
  options.desktop.sway = {
    enable = lib.mkEnableOption "Enable Sway";
  };

  config = lib.mkIf cfg.enable {
    # Enable Sway.
    programs.sway = {
      enable = true;
      package = pkgs.swayfx;
      wrapperFeatures.gtk = true;
    };

    # Xwayland
    programs.xwayland.enable = true;

    # Security
    services.gnome.gnome-keyring.enable = true;
    security.polkit.enable = true;

    # Dbus
    services.dbus.enable = true;

    # Portals
    xdg.portal = {
      enable = true;
      # wlr.enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };

    # Variables
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
}

{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.desktop.sddm;
in {
  options.desktop.sddm = {
    enable = lib.mkEnableOption "Enable SDDM";

    theme = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "SDDM Theme";
    };
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      theme = cfg.theme;
    };

    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtgraphicaleffects
    ];
  };
}

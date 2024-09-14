{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.apps.nautilus;
in {
  options.apps.nautilus = {
    enable = lib.mkEnableOption "Enable Nautilus";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      gnome.nautilus
    ];
  };
}

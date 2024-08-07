{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.sway;
in {
  imports = [
    ./wofi.nix
    ./config.nix
    ./waybar.nix
  ];

  options.desktop.sway = {
    enable = lib.mkEnableOption "Enable Sway Conf";
  };

  config = lib.mkIf cfg.enable {
    desktop.sway = {
      wofi.enable = lib.mkDefault true;
      config.enable = lib.mkDefault true;
      waybar.enable = lib.mkDefault true;
    };
  };
}

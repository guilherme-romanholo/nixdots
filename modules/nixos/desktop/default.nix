{
  lib,
  config,
  ...
}: let
  cfg = config.desktop;
in {
  imports = [
    ./sddm.nix
    ./bspwm.nix
    ./xserver.nix
    ./hyprland.nix
  ];

  options.desktop = {
    enable = lib.mkEnableOption "Enable Desktop Modules";
  };

  config = lib.mkIf cfg.enable {
    desktop = {
      sddm.enable = lib.mkDefault true;
      bspwm.enable = lib.mkDefault false;
      xserver.enable = lib.mkDefault true;
      hyprland.enable = lib.mkDefault false;
    };
  };
}

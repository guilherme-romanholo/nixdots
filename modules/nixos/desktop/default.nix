{
  lib,
  config,
  ...
}: let
  cfg = config.desktop;
in {
  imports = [
    ./sddm.nix
    ./sway.nix
    ./xserver.nix
  ];

  options.desktop = {
    enable = lib.mkEnableOption "Enable Desktop Modules";
  };

  config = lib.mkIf cfg.enable {
    desktop = {
      sddm.enable = lib.mkDefault true;
      sway.enable = lib.mkDefault false;
      xserver.enable = lib.mkDefault true;
    };
  };
}

{
  lib,
  config,
  ...
}: let
  cfg = config.desktop;
in {
  imports = [
    ./sddm.nix
    ./xserver.nix
  ];

  options.desktop = {
    enable = lib.mkEnableOption "Enable Desktop Modules";
  };

  config = lib.mkIf cfg.enable {
    desktop = {
      sddm.enable = lib.mkForce true;
      xserver.enable = lib.mkForce true;
    };
  };
}

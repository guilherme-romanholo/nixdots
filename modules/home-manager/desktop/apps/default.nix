{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.apps;
in {
  imports = [
    ./kitty.nix
  ];

  options.desktop.apps = {
    enable = lib.mkEnableOption "Enable Desktop Home Apps";
  };

  config = lib.mkIf cfg.enable {
    desktop.apps = {
      kitty.enable = lib.mkDefault true;
    };
  };
}

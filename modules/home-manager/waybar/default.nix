{
  lib,
  config,
  ...
}: let
  cfg = config.modules.waybar;
in {
  imports = [
    ./style.nix
    ./config.nix
    ./modules.nix
  ];

  options.modules.waybar = {
    enable = lib.mkEnableOption "Waybar";

    target = lib.mkOption {
      type = lib.types.str;
      default = "sway-session.target";
      description = "Inital target";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.waybar = {
      enable = true;

      systemd = {
        enable = true;
        target = cfg.target;
      };
    };
  };
}

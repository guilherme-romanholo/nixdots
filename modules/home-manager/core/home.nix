{
  lib,
  config,
  ...
}: let
  cfg = config.core.home;
in {
  options.core.home = {
    enable = lib.mkEnableOption "Enable Home Configs";

    username = lib.mkOption {
      type = lib.types.str;
      description = "Username";
    };

    stateVersion = lib.mkOption {
      type = lib.types.str;
      description = "Username";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      username = cfg.username;
      homeDirectory = "/home/${cfg.username}";
    };

    programs.home-manager.enable = true;
    home.stateVersion = cfg.stateVersion;
  };
}

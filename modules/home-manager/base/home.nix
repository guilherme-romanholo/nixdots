{
  lib,
  config,
  ...
}: let
  cfg = config.base.home;
in  {
  options.base.home = {
    enable = lib.mkEnableOption "Enable Home Configs";

    username = lib.mkOption {
      type = lib.types.str;
      description = "Username";
    };
  };

  config = lib.mkIf cfg.enable {
    home = {
      username = cfg.username;
      homeDirectory = "/home/${cfg.username}";
    };
  };
}

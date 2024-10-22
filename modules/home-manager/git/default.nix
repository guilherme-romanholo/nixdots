{
  lib,
  config,
  ...
}: let
  cfg = config.modules.git;
in {
  options.modules.git = {
    enable = lib.mkEnableOption "Git";

    username = lib.mkOption {
      type = lib.types.str;
      description = "Git Username";
    };

    email = lib.mkOption {
      type = lib.types.str;
      description = "Git Email";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.username;
      userEmail = cfg.email;
    };
  };
}
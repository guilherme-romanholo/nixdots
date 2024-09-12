{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.core.user;
in {
  options.core.user = {
    enable = lib.mkEnableOption "Enable User Module";

    users = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [];
      description = "List of users attributes";
      example = [
        {
          username = "foo";
          groups = ["wheel" "networkmanager"];
        }
      ];
    };

    authKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Public SSH Keys";
    };
  };

  config = lib.mkIf cfg.enable {
    # System users
    users.users = builtins.listToAttrs (map
      (user: {
        name = user.username;
        value = {
          initialPassword = "password";
          isNormalUser = true;
          # User groups
          extraGroups = user.groups;
          # Default shell
          shell = pkgs.zsh;
          ignoreShellProgramCheck = true;
          # Add your SSH public key(s) here, if you plan on using SSH to connect
          openssh.authorizedKeys.keys = cfg.authKeys;
        };
      })
      cfg.users);
  };
}

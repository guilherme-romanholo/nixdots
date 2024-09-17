{
  inputs,
  outputs,
  lib,
  config,
  ...
}: let
  cfg = config.core.hm;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options.core.hm = {
    enable = lib.mkEnableOption "Enable Home-Manager Module";

    hostAttrs = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Host attributes with user list";
      example = {
        hostname = "foo";
        users = [{username = "user1";} {username = "user2";}];
      };
    };

    homeConfig = lib.mkOption {
      type = lib.types.path;
      description = "Path to home configuration";
      example = ./home.nix;
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager = let
      host = cfg.hostAttrs;
    in {
      extraSpecialArgs = {inherit inputs outputs host;};
      users = builtins.listToAttrs (map
        (user: {
          name = user.username;
          value = import cfg.homeConfig {inherit outputs host user;};
        })
        host.users);
    };
  };
}

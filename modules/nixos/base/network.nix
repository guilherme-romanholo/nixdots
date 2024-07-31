{
  lib,
  config,
  ...
}: let
  cfg = config.base.network;
in {
  options.base.network = {
    enable = lib.mkEnableOption "Enable Network";

    hostname = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      description = "System Hostname";
    };

    networkmanager = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable NetworkManager";
    };
  };

  config = lib.mkIf cfg.enable {
    # Config hostname
    networking.hostName = cfg.hostname;

    # Enable networking
    networking.networkmanager.enable = cfg.networkmanager;

    # Extra hosts
    networking.extraHosts = ''
      127.0.0.1 localhost
      ::1 localhost
    '';
  };
}

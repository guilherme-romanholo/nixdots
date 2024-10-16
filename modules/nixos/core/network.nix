{
  lib,
  config,
  ...
}: let
  cfg = config.modules.network;
in {
  options.modules.network = {
    enable = lib.mkEnableOption "Network";

    networkmanager = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable NetworkManager";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable networking
    networking.networkmanager.enable = cfg.networkmanager;
    # Extra hosts
    networking.extraHosts = ''
      127.0.0.1 localhost
      ::1 localhost
    '';
  };
}

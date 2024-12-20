{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.core.network;
in {
  options.modules.core.network = with types; {
    enable = mkEnableOption "Network";
    networkmanager = mkOpt bool true;
  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager.enable = cfg.networkmanager;

      extraHosts = ''
        127.0.0.1 localhost
        ::1 localhost
      '';
    };
  };
}

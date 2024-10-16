{
  inputs,
  lib,
  config,
  ...
}: let
  cfg = config.modules.wsl;
in {
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  options.modules.wsl = {
    enable = lib.mkEnableOption "WSL";

    defaultUser = lib.mkOption {
      description = "Wsl Default User";
      type = lib.types.str;
      default = "nixos";
    };
  };

  config = lib.mkIf cfg.enable {
    wsl = {
      enable = true;
      defaultUser = cfg.defaultUser;
      startMenuLaunchers = true;
      usbip.enable = true;
      wslConf.network.generateHosts = false;
    };
  };
}

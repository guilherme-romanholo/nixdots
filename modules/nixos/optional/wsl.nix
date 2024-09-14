{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.optional.wsl;
in {
  options.optional.wsl = {
    enable = lib.mkEnableOption "Enable WSL Support";

    defaultUser = lib.mkOption {
      description = "Wsl Default User";
      type = lib.types.str;
      default = "nixos";
    };
  };

  config = lib.mkIf cfg.enable {
    imports = [
      nixos-wsl.nixosModules.wsl
    ];

    wsl = {
      enable = true;
      defaultUser = cfg.defaultUser;
      startMenuLaunchers = true;
      usbip.enable = true;
    };
  };
}
{
  lib,
  config,
  ...
}: let
  cfg = config.modules.core;
in {
  imports = [
    ./nix.nix
    ./sound.nix
    ./network.nix
    ./localtime.nix
    ./bootloader.nix
  ];

  options.modules.core = {
    enable = lib.mkEnableOption "Core";
  };

  config = lib.mkIf cfg.enable {
    modules = {
      nix.enable = true;
      sound.enable = true;
      network.enable = true;
      localtime.enable = true;
      bootloader.enable = true;
    };
  };
}

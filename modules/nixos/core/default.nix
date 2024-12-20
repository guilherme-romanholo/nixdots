{
  lib,
  config,
  ...
}:
with lib; let
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
    enable = mkEnableOption "Core";
  };

  config = mkIf cfg.enable {
    modules.core = {
      nix.enable = true;
      sound.enable = true;
      network.enable = true;
      localtime.enable = true;
      bootloader.enable = true;
    };
  };
}

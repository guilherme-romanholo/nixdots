{
  lib,
  config,
  ...
}: let
  cfg = config.base;
in {
  imports = [
    ./nix.nix
    ./user.nix
    ./sound.nix
    ./video.nix
    ./network.nix
    ./localtime.nix
    ./bootloader.nix
  ];

  options.base = {
    enable = lib.mkEnableOption "Enable Base Modules";
  };

  config = lib.mkIf cfg.enable {
    base = {
      nix.enable = lib.mkDefault true;
      user.enable = lib.mkDefault true;
      sound.enable = lib.mkDefault true;
      video.enable = lib.mkDefault true;
      network.enable = lib.mkDefault true;
      localtime.enable = lib.mkDefault true;
      bootloader.enable = lib.mkDefault true;
    };
  };
}

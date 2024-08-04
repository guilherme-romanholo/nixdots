{
  inputs,
  lib,
  ...
}: {
  imports = [
    ../general/configuration.nix
    inputs.nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    startMenuLaunchers = true;
  };

  # Disable unused base modules in wsl
  base = {
    sound.enable = lib.mkForce false;
    video.enable = lib.mkForce false;
    bootloader.enable = lib.mkForce false;
  };
}

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
    sound = lib.mkForce false;
    video = lib.mkForce false;
    bootloader = lib.mkForce false;
  };
}

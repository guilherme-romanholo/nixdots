{
  lib,
  config,
  ...
}: let
  cfg = config.base;
in {
  imports = [
    ./zsh
    ./git.nix
    ./home.nix
    ./nixpkgs.nix
  ];

  options.base = {
    enable = lib.mkEnableOption "Enable Base Home Modules";
  };

  config = lib.mkIf cfg.enable {
    base = {
      zsh.enable = lib.mkDefault true;
      git.enable = lib.mkDefault true;
      home.enable = lib.mkDefault true;
      nixpkgs.enable = lib.mkDefault true;
    };
  };
}

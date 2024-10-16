{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.docker;
in {
  options.modules.docker = {
    enable = lib.mkEnableOption "Docker";
  };

  config = lib.mkIf cfg.enable {
    # Enable dconf
    programs.dconf.enable = true;
    # Necessary packages
    environment.systemPackages = with pkgs; [
      docker
      docker-compose
    ];
    # Virtualization services
    virtualisation.docker.enable = true;
  };
}

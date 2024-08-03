{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.optional.docker;
in {
  options.optional.docker = {
    enable = lib.mkEnableOption "Enable Docker";
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

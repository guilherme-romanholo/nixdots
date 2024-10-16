{
  lib,
  config,
  ...
}: let
  cfg = config.modules.openssh;
in {
  options.modules.openssh = {
    enable = lib.mkEnableOption "Openssh";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      settings = {
        # Forbid root login through SSH.
        PermitRootLogin = "no";
        # Use keys only. Remove if you want to SSH using password (not recommended)
        PasswordAuthentication = false;
      };
    };
  };
}

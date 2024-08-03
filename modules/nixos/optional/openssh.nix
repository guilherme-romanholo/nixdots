{
  lib,
  config,
  ...
}: let
  cfg = config.optional.openssh;
in {
  options.optional.openssh = {
    enable = lib.mkEnableOption "Enable Openssh";
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

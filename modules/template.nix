{
  lib,
  config,
  ...
}: let
  cfg = config.modules.PROGRAM;
in {
  options.modules.PROGRAM = {enable = lib.mkEnableOption "PROGRAM";};
  config =
    lib.mkIf cfg.enable {
    };
}

{
  lib,
  config,
  ...
}: let
  cfg = config.modules.graphical;
in {
  imports = [
    ./opengl.nix
    ./xserver.nix
  ];

  options.modules.graphical = {
    enable = lib.mkEnableOption "Graphical";
  };

  config = lib.mkIf cfg.enable {
    modules = {
      opengl.enable = true;
      xserver.enable = true;
    };
  };
}

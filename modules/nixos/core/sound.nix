{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.sound;
in {
  options.modules.sound = {
    enable = lib.mkEnableOption "Sound";

    pipewire = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Pipewire";
    };

    jack = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Jack";
    };

    pulseaudio = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Pulseaudio";
    };
  };

  config = lib.mkIf cfg.enable {
    # Enable sound
    security.rtkit.enable = true;

    # Enable pulseaudio
    hardware.pulseaudio.enable = cfg.pulseaudio;

    # Enable pipewire
    services.pipewire = {
      enable = cfg.pipewire;

      alsa.enable = true;
      alsa.support32Bit = true;

      pulse.enable = true;

      jack.enable = cfg.jack;
    };

    # Add pavucontrol package
    environment.systemPackages = with pkgs; [
      pavucontrol
    ];
  };
}

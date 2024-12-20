{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.modules.core.sound;
in {
  options.modules.core.sound = with types; {
    enable = mkEnableOption "Sound";
    pipewire = mkOpt bool true;
    jack = mkOpt bool false;
    pulseaudio = mkOpt bool false;
  };

  config = mkIf cfg.enable {
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

{
  programs.waybar = {
    settings = {
      mainBar = {
        modules-left = [
          "custom/logo"
          "sway/workspaces"
          "tray"
        ];

        modules-center = [
          "temperature"
          "cpu"
          "memory"
          "disk"
        ];

        modules-right = [
          "pulseaudio"
          "backlight"
          "battery"
          "bluetooth"
          "network"
          "clock"
          "custom/power"
        ];
      };
    };
  };
}

{
  programs.waybar.settings.mainBar = {
    "temperature" = {
      interval = 10;
      critical-threshold = 80;
      format-critical = "  {temperatureC}°C";
      format = "{icon} {temperatureC}°C";
      hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
      format-icons = ["" "" "" ""];
    };
  };
}

{pkgs, ...}: {
  programs.waybar.settings.mainBar = {
    "bluetooth" = {
      format = "";
      format-on = "󰂯";
      format-off = "󰂲";
      format-disabled = "󰂲";
      format-connected = "󰂱";
      on-click = "${pkgs.rofi-bluetooth}/bin/rofi-bluetooth";
    };
  };
}

{
  programs.waybar.settings.mainBar = {
    "battery" = {
      format = "{icon}";
      format-charging = "{icon}";
      format-warning = "{capacity}%";
      format-critical = "{capacity}%";
      tooltip = true;
      tooltip-format = "{capacity}%";
      states = {
        warning = 30;
        critical = 15;
      };
      format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󱟢"];
    };
  };
}

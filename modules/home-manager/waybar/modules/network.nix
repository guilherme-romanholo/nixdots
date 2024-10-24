{
  programs.waybar.settings.mainBar = {
    "network" = {
      interval = 10;
      format-wifi = "{icon}  {essid}";
      format-ethernet = "󰈀  eth";
      format-disconnected = "  Disconneted";
      format-icons = ["󰤟" "󰤢" "󰤥" "󰤨"];
      tooltip-format = "{ifname}";
    };
  };
}

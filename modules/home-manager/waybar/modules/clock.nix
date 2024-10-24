{
  programs.waybar.settings.mainBar = {
    "clock" = {
      interval = 60;
      format = "  {:%H:%M}";
      format-alt = "  {:%b %d}";
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    };
  };
}

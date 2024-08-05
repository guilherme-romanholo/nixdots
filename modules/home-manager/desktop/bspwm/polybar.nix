{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.bspwm.polybar;
in {
  options.desktop.bspwm.polybar = {
    enable = lib.mkEnableOption "Enable Desktop Polybar";
  };

  config = lib.mkIf cfg.enable {
    services.polybar = {
      enable = true;
      script = "polybar -q top &";

      settings = {
        "bar/top" = {
          width = "100%";
          height = "3%";

          radius = 0;

	  bottom = false;
	  fixed-center = true;

	  background = "${config.lib.stylix.colors.base00}";
	  foreground = "${config.lib.stylix.colors.base05}";

	  format-background = "${config.lib.stylix.colors.base00}";
	  format-foreground = "${config.lib.stylix.colors.base05}";

	  line-size = 2;
	  line-color = "${config.lib.stylix.colors.base05}";

	  border-size = 4;
	  border-color = "${config.lib.stylix.colors.base00}";

	  font-0 = "${config.stylix.fonts.monospace.name}:size=${toString config.stylix.fonts.sizes.applications};3";

	  padding = 1;

          modules-left = "mod sep bspwm";
          modules-center = "date";
        };

        "module/mod" = {
          type = "internal/bspwm";
	  format = "<label-mode>";

	  format-background = "${config.lib.stylix.colors.base0A}";
	  format-foreground = "${config.lib.stylix.colors.base00}";
	  format-padding = 1;
	  
	  label-monocle = "Monocle";
	  label-tiled = "Tiled";
	  label-floating = ", Float";
	  label-pseudotiled = ", Pseudo";
	  label-fullscreen = ", Full";
        };

        "module/date" = {
          type = "internal/date";
          internal = 5;
          date = "%d/%m/%y";
          time = "%H:%M";
          label = "%time% | %date%";
        };

        "module/bspwm" = {
          type = "internal/bspwm";
	  format = "<label-state>";
	  label-padding = 2;
          pin-workspaces = true;
        };

	"module/sep"= {
	  type = "custom/text";
	  content = " ";
	  
	  content-background = "${config.lib.stylix.colors.base00}";
	  content-foreground = "${config.lib.stylix.colors.base01}";
	  content-padding = 2;
	};
      };
    };
  };
}

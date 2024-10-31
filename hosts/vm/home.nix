{pkgs, ...}: {
  modules = {
    sway.enable = true;
    wofi.enable = true;
    waybar.enable = true;
  };

  home.packages = with pkgs; [
    nautilus
  ];
}

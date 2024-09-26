{ pkgs, ... }: {
  apps = {
    kitty.enable = true;
    firefox.enable = true;
    nautilus.enable = true;
  };

  home.packages = with pkgs; [
    vesktop
  ];
}

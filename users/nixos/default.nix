{pkgs, ...}: {
  modules = {
    fish.enable = true;
  };

  programs = {
    firefox.enable = true;
  };

  home.packages = with pkgs; [
    vesktop
  ];
}

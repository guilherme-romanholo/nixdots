{pkgs, ...}: {
  terminal = {
    fish.enable = true;
  };

  home.packages = with pkgs; [
    neovim
  ];
}

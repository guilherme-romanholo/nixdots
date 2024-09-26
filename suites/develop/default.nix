{pkgs, ...}: {
  apps = {
    vscode.enable = true;
  };

  home.packages = with pkgs; [
    neovim
  ];
}

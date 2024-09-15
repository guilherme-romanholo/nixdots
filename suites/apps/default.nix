{outputs, ...}: {
  imports = [
    outputs.homeManagerModules.apps
  ];

  apps = {
    kitty.enable = true;
    firefox.enable = true;
    nautilus.enable = true;
  };
}

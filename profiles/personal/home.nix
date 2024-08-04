{
  outputs,
  ...
}: {
  imports = [
    ../general/home.nix
    outputs.homeManagerModules.desktop
  ];

  desktop = {
    # Enable home desktop configurations
    enable = true;
    # Enable bspwm home config
    bspwm.enable = true;
    # Enable desktop home apps
    apps.enable = true;
  };
}

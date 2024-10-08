{
  outputs,
  ...
}: {
  imports = [
    outputs.homeManagerModules.desktop
  ];

  desktop = {
    i3 = {
      enable = true;
    };
  };
}

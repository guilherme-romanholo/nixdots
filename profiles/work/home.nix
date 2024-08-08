{
  pkgs,
  ...
}: {
  imports = [
    ../personal/home.nix
  ];

  home.packages = [
    pkgs.jetbrains.pycharm-professional
  ];
}

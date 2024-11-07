{
  overlays,
  ...
}: {
  username,
  hostname,
  stateVersion,
}:
{
  imports = [
    ../users/${username}
    ../modules/home-manager
    ../hosts/${hostname}/home.nix
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    inherit stateVersion;
  };

  systemd.user.startServices = "sd-switch";
}

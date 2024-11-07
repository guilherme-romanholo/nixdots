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

  nixpkgs = {
    overlays = [
      overlays.additions
      overlays.modifications
      overlays.stable-packages
    ];
    config.allowUnfree = true;
  };

  systemd.user.startServices = "sd-switch";
}

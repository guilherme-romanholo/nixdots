{
  outputs,
  user,
  host,
  ...
}: {
  imports = [
    outputs.homeManagerModules.base
  ];

  base = {
    # Enable common modules
    enable = true;
    # Config git
    git = {
      username = user.username;
      email = user.email;
    };
    # Config home
    home.username = user.username;
  };

  home.stateVersion = host.systemVersion;
  systemd.user.startServices = "sd-switch";
}

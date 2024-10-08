{
  outputs,
  user,
  host,
  ...
}: {
  imports =
    [
      outputs.homeManagerModules.core
      outputs.homeManagerModules.apps
      outputs.homeManagerModules.desktop
      outputs.homeManagerModules.optional
    ]
    ++ map (suite: ./. + "/${suite}") user.suites
    ++ map (desktop: ./desktop + "/${desktop}.nix") user.desktops;

  core = {
    home = {
      enable = true;
      username = user.username;
      stateVersion = host.stateVersion;
    };

    git = {
      enable = true;
      username = user.username;
      email = user.email;
    };

    nixpkgs.enable = true;
  };
}

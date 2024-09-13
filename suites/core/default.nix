{
  outputs,
  host,
  user,
  ...
}: {
  imports = [
    outputs.homeManagerModules.core
  ];

  core = {
    home = {
      enable = true;
      username = user.username;
      stateVersion = host.stateVersion;
    };

    nixpkgs.enable = true;
  };
}

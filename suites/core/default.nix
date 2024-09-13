{
  outputs,
  host,
  user,
  ...
}: {
  imports = [
    outputs.homeManagerModules.core
  ];

  base = {
    home = {
      enable = true;
      username = user.username;
      stateVersion = host.stateVersion;
    };

    nixpkgs.enable = true;
  };
}

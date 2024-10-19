{
  name,
  groups,
  shell,
  authKeys ? [],
  config,
}: {
  inherit name shell;

  system = {
    isNormalUser = true;
    extraGroups = groups;

    ignoreShellProgramCheck = true;

    initialPassword = "password";
    openssh.authorizedKeys.keys = authKeys;
  };

  hm =
    {
      home = {
        username = name;
        homeDirectory = "/home/${name}";
      };

      # TODO: Add overlays
      nixpkgs = {
        config = {
          allowUnfree = true;
        };
      };

      systemd.user.startServices = "sd-switch";
    }
    // import config;
}

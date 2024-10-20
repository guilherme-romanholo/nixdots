{
  name,
  groups,
  shell,
  authKeys ? [],
}: {
  inherit name shell;

  system = {
    isNormalUser = true;
    extraGroups = groups;

    ignoreShellProgramCheck = true;

    initialPassword = "password";
    openssh.authorizedKeys.keys = authKeys;
  };

  hm = {
    imports = [
      ../users/${name}
      ../modules/home-manager
    ];

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
  };
}

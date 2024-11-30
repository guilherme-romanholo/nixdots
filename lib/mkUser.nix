{
  name,
  groups,
  shell,
  authKeys ? [],
}: {
  inherit name;

  config = {pkgs}: {
    shell = pkgs.${shell};

    isNormalUser = true;
    extraGroups = groups;

    ignoreShellProgramCheck = true;

    initialPassword = "password";
    openssh.authorizedKeys.keys = authKeys;
  };

  home = {
    hostname,
    stateVersion,
  }: {
    imports = [
      ../users/${name}
      ../modules/home-manager
      ../hosts/${hostname}/home.nix
    ];

    home = {
      username = name;
      homeDirectory = "/home/${name}";
      inherit stateVersion;
    };

    systemd.user.startServices = "sd-switch";
  };
}

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
}

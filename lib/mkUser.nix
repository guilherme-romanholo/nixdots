{
  name,
  groups,
  shell,
  authKeys ? [],
}: {
  inherit name;
  inherit shell;

  config = {
    isNormalUser = true;
    extraGroups = groups;

    ignoreShellProgramCheck = true;

    initialPassword = "password";
    openssh.authorizedKeys.keys = authKeys;
  };
}

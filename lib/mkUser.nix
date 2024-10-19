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
    # TODO: If groups exists
    extraGroups = groups;

    ignoreShellProgramCheck = true;

    initialPassword = "password";
    openssh.authorizedKeys.keys = authKeys;
  };

  hm =
    {
    }
    // config;
}

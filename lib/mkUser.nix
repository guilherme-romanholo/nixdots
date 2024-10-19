{
  name,
  groups,
  shell,
  authKeys ? [],
}: {
  system = {
    inherit name;
    value = {
      isNormalUser = true;
      extraGroups = groups;

      shell = pkgs.${shell};
      ignoreShellProgramCheck = true;

      initialPassword = "password";
      openssh.authorizedKeys.keys = authKeys;
    };
  };
}

{lib, ...}: {
  flake.aspects.user = {
    name,
    admin,
    shell,
  }: {
    nixos = {pkgs, ...}: {
      users.users.${name} = {
        isNormalUser = true;
        initialPassword = "password";

        extraGroups = lib.optionals admin [
          "wheel"
          "networkmanager"
        ];

        shell = pkgs.${shell};
        ignoreShellProgramCheck = true;
      };
    };
  };
}

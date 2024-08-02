{
  outputs,
  host,
  ...
}: {
  imports = [
    outputs.nixosModules.base
  ];

  base = {
    # Enable common modules
    enable = true;
    # Config network
    network.hostname = host.hostname;
    # Config User
    user.users = host.users;
    # Config video
    video.driver = host.videoDriver;
    # Config nix
    nix = {
      substituters = [
	"https://hyprland.cachix.org"
      ];
      trustedKeys = [
	"hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
    # Config timezone
    localtime = {
      timezone = host.timezone;
      locale = host.locale;
      consoleKeymap = "${host.kblayout}-abnt2";
    };
    # Bootloader
    bootloader = {
      bootmode = host.bootmode;
      device = host.grubDevice;
    };
  };

  system.stateVersion = host.systemVersion;
}

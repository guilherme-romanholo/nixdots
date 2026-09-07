{self, ...}: {
  flake.aspects.desktop = {
    includes = with self.aspects; [
      # Profile
      base

      # System
      boot
      audio
      graphics

      # Hardware
      ssd
      firmware

      # Services
      openssh
      printing
      tailscale
    ];
  };
}

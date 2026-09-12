{self, ...}: {
  flake.aspects.sunset = {
    includes = with self.aspects; [
      desktop
      mango
    ];

    nixos.system.stateVersion = "26.11";
  };
}

{self, ...}: {
  flake.aspects.sunset = {
    includes = with self.aspects; [
      desktop
      zen
      mango
      kitty
    ];

    nixos.system.stateVersion = "26.11";
  };
}

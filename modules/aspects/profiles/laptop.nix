{self, ...}: {
  flake.aspects.laptop = {
    includes = with self.aspects; [
      # Profile
      desktop

      # Hardware
      battery
      bluetooth
    ];
  };
}

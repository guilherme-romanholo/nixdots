{self, ...}: {
  flake.aspects.vortex = {
    includes = with self.aspects; [
      base
      wsl
    ];

    nixos = {
      system.stateVersion = "26.11";
      nixpkgs.hostPlatform = "x86_64-linux";
    };
  };
}

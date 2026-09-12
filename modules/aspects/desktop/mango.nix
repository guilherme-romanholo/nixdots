{self, ...}: {
  flake.aspects.mango = {
    includes = with self.aspects; [
      noctalia
    ];

    nixos = {pkgs, ...}: {
      programs.mango = {
        enable = true;
        package = self.inputs.wrappers.wrappers.mangowc.wrap {
          inherit pkgs;
          settings.exec-once = "noctalia";
        };
      };
    };
  };
}

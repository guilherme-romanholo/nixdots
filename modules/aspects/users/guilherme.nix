{self, ...}: {
  flake.aspects.guilherme = {
    includes = with self.aspects; [
      (user {
        admin = true;
        shell = "fish";
        name = "guilherme";
      })
    ];

    nixos = {pkgs, ...}: {
      users.users.guilherme.packages = with pkgs; [
        git
        helix
      ];
    };

    persist.users.guilherme = {
      directories = [".nixdots"];
    };
  };
}

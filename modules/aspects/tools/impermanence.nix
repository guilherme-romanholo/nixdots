{inputs, ...}: {
  flake.aspects.impermanence = {
    includes = [];

    nixos = {
      imports = [
        inputs.impermanence.nixosModules.impermanence
      ];

      environment.persistence."/persist" = {
        enable = true;
        hideMounts = true;
      };
    };

    persist = {
      files = [
        "/etc/machine-id"
      ];

      directories = [
        "/var/log"
        "/var/lib/nixos"
      ];
    };
  };
}

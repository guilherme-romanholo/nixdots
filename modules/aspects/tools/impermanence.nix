{
  inputs,
  lib,
  den,
  ...
}: {
  flake.aspects.impermanence = {
    includes = [
      ({
        class,
        aspect-chain,
      }:
        den.forward {
          each = lib.singleton true;
          fromClass = _: "persist";
          intoClass = _: "nixos";
          intoPath = _: ["environment" "persistence" "/persist"];
          fromAspect = _: lib.head aspect-chain;
        })
    ];

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

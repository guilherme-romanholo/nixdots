{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.flake-aspects.flakeModule
  ];

  systems = [
    "x86_64-linux"
  ];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";

    programs = {
      taplo.enable = true;
      alejandra.enable = true;
    };
  };

  flake.nixosConfigurations = lib.mapAttrs (
    name: _:
      inputs.nixpkgs.lib.nixosSystem {
        modules = [inputs.self.modules.nixos.${name}];
      }
  ) (builtins.readDir ./hosts);
}

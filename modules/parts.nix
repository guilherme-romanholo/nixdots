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

  _module.args.den = inputs.flake-aspects.lib lib;

  #-----------#
  #  Outputs  #
  #-----------#

  perSystem.treefmt = {
    projectRootFile = "flake.nix";

    programs = {
      taplo.enable = true;
      alejandra.enable = true;
    };
  };

  flake.nixosConfigurations =
    lib.flip
    lib.mapAttrs (builtins.readDir ./hosts) (
      name: _:
        inputs.nixpkgs.lib.nixosSystem {
          modules = [inputs.self.modules.nixos.${name}];
        }
    );
}

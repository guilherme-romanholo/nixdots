{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...} @ inputs: {
    # NixOS Configurations
    nixosConfigurations = {
      # VM Config
      vm = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/vm/configuration.nix
          ./hosts/vm/hardware-configuration.nix
        ];
      };
    };
  };
}

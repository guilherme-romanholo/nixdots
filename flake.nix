{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    inherit (nixpkgs) lib;

    # Import myLib functions
    myLib = import ./lib {inherit lib inputs;};
  in {
    # NixOS Configurations
    nixosConfigurations = {
      # VM Config
      vm = myLib.mkHost {
        hostname = "vm";
        system = "x86_64-linux";
        stateVersion = "24.05";
      };
    };
  };
}

{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    # Nixpkgs Lib
    inherit (nixpkgs) lib;
    # Lib with my functions
    myLib = import ./lib {inherit lib inputs;};
  in {
    # NixOS Configurations
    nixosConfigurations = {
      # Test VM Config
      vm = myLib.mkHost {
        hostname = "vm";
        system = "x86_64-linux";
        stateVersion = "24.05";
        config = import ./hosts/vm;
      };
    };
  };
}

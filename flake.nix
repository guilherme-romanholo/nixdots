{
  description = "NixOS Configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    # Lib with my functions
    myLib = import ./lib {inherit inputs nixpkgs;};
    # Users
    users = import ./users {inherit myLib;};
  in {
    # NixOS Configurations
    nixosConfigurations = {
      # Test VM Config
      vm = myLib.mkHost {
        hostname = "vm";
        system = "x86_64-linux";
        users = [users.nixos];
        stateVersion = "24.05";
        config = import ./hosts/vm;
      };
    };
  };
}

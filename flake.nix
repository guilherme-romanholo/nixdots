{
  description = "NixOS Configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    # Home-Manager
    # home-manager.url = "github:nix-community/home-manager";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    inherit (nixpkgs) lib;
    # Lib with my functions
    myLib = import ./lib {inherit lib inputs;};
    # Test user
    myUser = myLib.mkUser {
      name = "nixos";
      shell = "zsh";
      groups = ["wheel" "networkmanager"];
    };
  in {
    # NixOS Configurations
    nixosConfigurations = {
      # Test VM Config
      vm = myLib.mkHost {
        hostname = "vm";
        system = "x86_64-linux";
        stateVersion = "24.05";
        config = import ./hosts/vm;
        users = [myUser.system];
      };
    };
  };
}

{
  description = "NixOS Configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home-Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    # Stylix
    stylix.url = "github:danth/stylix";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    #########
    #  LIB  #
    #########
    myLib = import ./lib {inherit inputs nixpkgs home-manager;};

    #########
    # USERS #
    #########
    users = {
      nixos = myLib.mkUser {
        name = "nixos";
        shell = "fish";
        groups = ["wheel" "networkmanager"];
      };
    };

    #########
    # HOSTS #
    #########
    hosts = {
      vm = myLib.mkHost {
        hostname = "vm";
        system = "x86_64-linux";
        users = [users.nixos];
        stateVersion = "24.05";
      };
    };
  in {
    # NixOS Configurations
    nixosConfigurations = hosts;
  };
}

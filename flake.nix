{
  description = "NixOS Configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    # Home-Manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    # Stylix
    stylix.url = "github:danth/stylix";
    # Nixvim
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = {
    nixpkgs,
    ...
  } @ inputs: let
    # Overlays
    overlays = import ./overlays {inherit inputs;};
    # My Lib
    myLib = import ./lib {inherit inputs overlays;};
    # Nixvim
    nixvim = myLib.forAllSystems (system: myLib.mkNvim {inherit system;});
    # My custom packages
    packages = myLib.forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # Users
    users = {
      nixos = myLib.mkUser {
        name = "nixos";
        shell = "fish";
        groups = ["wheel" "networkmanager"];
      };
    };

    # Hosts
    hosts = {
      vm = myLib.mkHost {
        hostname = "vm";
        system = "x86_64-linux";
        users = [users.nixos];
        stateVersion = "24.05";
      };
    };
  in {
    # Custom packages (nix shell, nix build, ...)
    packages = packages // nixvim;
    # Nixos Configurations
    nixosConfigurations = hosts;
  };
}

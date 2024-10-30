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
    # MyLib
    myLib = import ./lib {inherit inputs nixpkgs home-manager overlays;};
    # Overlays
    overlays = import ./overlays;
    # Packages
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
    inherit packages;
    # Nixos Configurations
    nixosConfigurations = hosts;
  };
}

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
    inherit (nixpkgs) lib;
    # For All Systems
    forAllSystems = lib.genAttrs lib.systems.flakeExposed;
    # Packages with nix build, nix shell, ...
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Overlays
    overlays = import ./overlays;
    # MyLib
    myLib = import ./lib {inherit inputs nixpkgs home-manager overlays;};
    # Users
    users = {
      nixos = myLib.mkUser {
        name = "nixos";
        shell = "fish";
        groups = ["wheel" "networkmanager"];
      };
    };
  in {
    # Custom packages
    inherit packages;

    # Nixos Configurations
    nixosConfigurations = {
      vm = myLib.mkHost {
        hostname = "vm";
        system = "x86_64-linux";
        users = [users.nixos];
        stateVersion = "24.05";
      };
    };
  };
}

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

  outputs = {nixpkgs, ...} @ inputs: let
    # Lib
    lib = import ./lib {inherit inputs overlays;};
    # Overlays
    overlays = import ./overlays {inherit inputs;};
    # Nixvim
    nixvim = lib.forAllSystems (system: lib.mkNvim {inherit system;});
    # My custom packages
    packages = lib.forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # Users
    users = {
      nixos = lib.mkUser {
        name = "nixos";
        shell = "fish";
        groups = ["wheel" "networkmanager"];
      };
    };

    # Hosts
    hosts = {
      vm = lib.mkHost {
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

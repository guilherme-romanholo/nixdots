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
    # System archs
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # For All Systems
    forAllSystems = nixpkgs.lib.genAttrs systems;
    # Overlays
    overlays = import ./overlays;
    # MyLib
    myLib = import ./lib {inherit inputs nixpkgs home-manager overlays;};

    users = {
      nixos = myLib.mkUser {
        name = "nixos";
        shell = "fish";
        groups = ["wheel" "networkmanager"];
      };
    };
  in {
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

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

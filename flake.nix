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
    nixosConfigurations = import ./hosts {inherit myLib;};
  };
}

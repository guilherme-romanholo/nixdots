{
  description = "NixOS Flake Configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # Nixpkgs Unstable
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Nixvim
    nixvim.url = "github:guilherme-romanholo/nixvim";
    # WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    # Stylix
    stylix.url = "github:danth/stylix";
    # Disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Import hosts
    hosts =
      builtins.map (host: import host)
      (builtins.map (file: (builtins.toString ./hosts) + "/" + file)
        (builtins.attrNames
          (builtins.removeAttrs (builtins.readDir ./hosts) ["template"])));

    # Define lib to use in flake
    lib = nixpkgs.lib // home-manager.lib;

    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    inherit lib;

    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # Formatter for your nix files, available through 'nix fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs lib;};

    # Reusable nixos modules you might want to export
    nixosModules = import ./modules/nixos;

    # Reusable home-manager modules you might want to export
    homeManagerModules = import ./modules/home-manager;

    # NixOS System Configurations
    nixosConfigurations = builtins.listToAttrs (map
      (host: {
        name = host.hostname;
        value = lib.nixosSystem {
          modules = [
            ./hosts/${host.hostname}/configuration.nix
          ];
          specialArgs = {
            inherit inputs;
            inherit outputs;
          };
        };
      })
      hosts);

    # NixOS Home Configurations
    homeConfigurations = lib.attrsets.mergeAttrsList (map (host:
      builtins.listToAttrs (map (user: {
          name = user.username + "@" + host.hostname;
          value = lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.${host.system};
            modules = [
              ./suites
            ];
            extraSpecialArgs = {
              inherit host;
              inherit user;
              inherit inputs;
              inherit outputs;
            };
          };
        })
        host.users))
    hosts);
  };
}

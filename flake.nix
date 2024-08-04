{
  description = "NixOS Flake Configuration";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    # Nixpkgs Unstable
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # WSL
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Nixvim
    nixvim.url = "github:guilherme-romanholo/nixvim";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Import hosts
    hosts = import ./hosts;

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
    overlays = import ./overlays {inherit inputs;};

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
            ./hosts/${host.hostname}-hardware.nix
            ./profiles/${host.profile}/configuration.nix
	    ./scripts
          ];
          specialArgs = {
            inherit host;
            inherit inputs;
            inherit outputs;
          };
        };
      })
      hosts.hosts);

    # NixOS Home Configurations
    homeConfigurations = lib.attrsets.mergeAttrsList (map (host:
      builtins.listToAttrs (map (user: {
          name = user.username + "@" + host.hostname;
          value = lib.homeManagerConfiguration {
            # TODO: Generalize packages
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = {
              inherit host;
              inherit user;
              inherit inputs;
              inherit outputs;
            };
            modules = [
              ./profiles/${host.profile}/home.nix
            ];
          };
        })
        host.users))
    hosts.hosts);
  };
}

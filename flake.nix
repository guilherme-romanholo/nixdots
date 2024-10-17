{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    inherit (nixpkgs) lib;
    myLib = import ./lib {inherit lib inputs;};
  in {
    # NixOS Configurations
    nixosConfigurations = {
      # VM Config
      vm = myLib.mkHost {
        hostname = "vm";
        system = "x86_64-linux";
        stateVersion = "24.05";

        locale = "pt_BR.UTF-8";
        timezone = "America/Sao_Paulo";

        grubDevice = "/dev/vda";

        users = [
          {username = "nixos"; groups = ["networkmanager" "wheel"];}
        ];

        config = import ./hosts/vm;
      };
    };
  };
}

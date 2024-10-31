{inputs, ...}: let
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # Custom nixvim overlay
    neovim = inputs.self.packages.${final.system}.nvim;
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    #
    # });
  };

  # Accessible through 'pkgs.stable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
in {
  nixpkgs = {
    overlays = [
      additions
      modifications
      stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };
}

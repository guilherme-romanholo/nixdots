{
  inputs,
  ...
}: let
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # Accessible through 'pkgs.stable'
  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  # This one contains whatever you want to overlay
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    #
    # });
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

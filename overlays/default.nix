# This file defines overlays
let
  additions = final: _prev: import ../pkgs final.pkgs;

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
    ];

    config = {allowUnfree = true;};
  };
}

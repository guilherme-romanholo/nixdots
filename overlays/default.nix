# This file defines overlays
{
  inputs,
  lib,
  ...
}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # Custom nixvim overlay
    neovim = inputs.nixvim.packages.${final.system}.default.nixvimExtend {
      config.colorschemes.base16.colorscheme = lib.mkForce (import ../themes).colorscheme;
    };
    # Remove spaces from theme name
    capitaine-cursors-themed = prev.capitaine-cursors-themed.overrideAttrs (oldAttrs: {
      installPhase =
        oldAttrs.installPhase
        + ''
          cd $out/share/icons
          mv "Capitaine Cursors (Gruvbox)" "Capitaine-Cursors-Gruvbox"
        '';
    });
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # });
  };
}

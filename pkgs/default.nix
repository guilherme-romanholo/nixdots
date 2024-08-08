# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  gruvbox-icons-plus = pkgs.callPackage ./gruvbox-icons-plus.nix { };
}

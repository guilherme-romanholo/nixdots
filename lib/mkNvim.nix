{
  nixpkgs,
  inputs,
  ...
}: {system}: let
  # Pkgs
  pkgs = import nixpkgs {inherit system;};
  # Nixvim
  nixvim' = inputs.nixvim.legacyPackages.${system};
  # Module settings
  nixvimModule = {
    inherit pkgs;
    module = import ../modules/nixvim;
  };
in {
  nvim = nixvim'.makeNixvimWithModule nixvimModule;
}

{
  system,
  nixpkgs,
  overlays,
  ...
}: import nixpkgs {
  # System Arch
  inherit system;
  # Overlays
  overlays = [
    overlays.additions
    overlays.modifications
    overlays.stable-packages
  ];
  # Allow Unfree Packages
  config.allowUnfree = true;
}

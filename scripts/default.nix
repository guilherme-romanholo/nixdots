{pkgs, ...}: {
  environment.systemPackages = [
    (import ./rebuild.nix {inherit pkgs;})
    (import ./theme-switch.nix {inherit pkgs;})
  ];
}

{
  flake.aspects.kitty.nixos = {pkgs, ...}: {
    environment.systemPackages = [pkgs.kitty];
  };
}

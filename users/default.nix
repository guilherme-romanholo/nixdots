{myLib, ...}: {
  nixos = myLib.mkUser {
    name = "nixos";
    shell = "fish";
    groups = ["wheel" "networkmanager"];
    config = ./nixos;
  };
}

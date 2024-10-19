{myLib, ...}: {
  nixos = myLib.mkUser {
    name = "nixos";
    shell = "zsh";
    groups = ["wheel" "networkmanager"];
    config = ./nixos;
  };
}

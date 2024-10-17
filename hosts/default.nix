{myLib, ...}: {
  # VM Config
  vm = myLib.mkHost {
    hostname = "vm";
    system = "x86_64-linux";
    stateVersion = "24.05";
    locale = "pt_BR.UTF-8";
    timezone = "America/Sao_Paulo";
    grubDevice = "/dev/vda";
    users = [
      {
        username = "nixos";
        groups = ["networkmanager" "wheel"];
      }
    ];
    config = import ./vm;
  };
}

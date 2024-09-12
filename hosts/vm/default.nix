{
  # System informations
  hostname = "vm";
  system = "x86_64-linux";
  stateVersion = "24.05";

  # Users informations
  users = [
    {
      # User
      username = "guilherme";
      groups = ["networkmanager" "wheel"];
      # Git
      gituser = "guilherme-romanholo";
      email = "guilhermeromanholobofo@gmail.com";
      # Suites
      suites = ["base" "terminal"];
    }
  ];
}

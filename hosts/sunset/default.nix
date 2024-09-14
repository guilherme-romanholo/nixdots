{
  # System informations
  hostname = "sunset";
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
      suites = ["terminal" "desktop" "apps"];
      # Only if desktop suite is enabled
      desktops = ["sway"];
    }
  ];
}

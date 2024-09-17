{
  # System informations
  hostname = "sunset";

  system = "x86_64-linux";
  stateVersion = "24.05";

  locale = "pt_BR.UTF-8";
  kblayout = "br";
  timezone = "America/Sao_Paulo";

  videoDriver = "amdgpu";

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
      suites = ["terminal" "apps" "colors"];
      # Only if desktop suite is enabled
      desktops = ["sway"];
    }
  ];
}

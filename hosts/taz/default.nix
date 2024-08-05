{
  # Host
  system = "x86_64-linux";
  profile = "work";
  bootmode = "grub";
  hostname = "taz";
  grubDevice = "/dev/sda";
  videoDriver = "i915";
  stateVersion = "24.05";
  # Locale
  locale = "pt_BR.UTF-8";
  timezone = "America/Sao_Paulo";
  kblayout = "br";
  # Users
  users = [
    {
      username = "guilherme";
      email = "guilhermeromanholobofo@gmail.com";
      gituser = "guilherme-romanholo";
      groups = ["wheel" "networkmanager"];
    }
  ];
}

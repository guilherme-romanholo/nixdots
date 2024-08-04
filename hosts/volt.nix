{
  # Host
  hostname = "volt";
  profile = "personal";
  bootmode = "uefi";
  grubDevice = "null";
  systemVersion = "24.05";
  videoDriver = "amdgpu";
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
      groups = ["wheel" "networkmanager" "docker" "libvirt"];
    }
  ];
}

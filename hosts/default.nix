{
  # Hosts settings
  hosts = [
    {
      # Host
      hostname = "testvm";
      profile = "personal";
      bootmode = "grub";
      grubDevice = "/dev/vda";
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
          groups = ["wheel" "networkmanager"];
        }
      ];
    }
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
  ];
}

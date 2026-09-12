{self, ...}: {
  flake.aspects.sunset = {
    includes = [
      (self.aspects.disko {
        size = "465G";
        swap = "8G";
        device = "/dev/nvme0n1";
      })
    ];

    nixos = {
      boot.kernelModules = ["kvm-amd"];

      boot.initrd.availableKernelModules = [
        "nvme"
        "ahci"
        "usbhid"
        "xhci_pci"
      ];

      nixpkgs.hostPlatform = "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = true;
    };
  };
}

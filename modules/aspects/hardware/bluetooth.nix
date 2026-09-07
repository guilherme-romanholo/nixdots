{
  flake.aspects.bluetooth = {
    nixos.hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    persist.directories = [
      "/var/lib/bluetooth"
    ];
  };
}

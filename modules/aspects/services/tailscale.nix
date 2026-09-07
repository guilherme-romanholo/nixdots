{
  flake.aspects.tailscale = {
    nixos.services.tailscale.enable = true;

    persist.directories = [
      "/var/lib/tailscale"
    ];
  };
}

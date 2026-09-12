{inputs, ...}: {
  flake.aspects.zen.nixos = {pkgs, ...}: {
    environment.systemPackages = [
      (inputs.zen-browser.packages.${pkgs.hostPlatform.system}.default.override {
        extraPolicies.DisableTelemetry = true;
      })
    ];
  };
}

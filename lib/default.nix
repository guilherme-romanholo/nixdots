{
  lib,
  inputs,
  ...
}: {
  mkHost = import ./mkHost.nix {inherit lib inputs;};
}

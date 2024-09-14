{
  user,
  ...
}: {
  imports = map (desktop: ./. + "/${desktop}.nix") user.desktops;
}

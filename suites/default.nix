{
  user,
  ...
}: {
  imports = [
    ./core
  ] ++ map (suite: ./. + "/${suite}") user.suites;
}

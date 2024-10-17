{myLib, ...}: {
  # VM Config
  vm = myLib.mkHost import ./vm;
}

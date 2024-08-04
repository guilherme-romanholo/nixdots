let
  files = [
    ./volt.nix
    ./testvm.nix
    ./vivobook.nix
  ];
  importHosts = host: import host;
  hosts = builtins.map importHosts files;
in 
  hosts

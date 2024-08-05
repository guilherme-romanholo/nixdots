let
  files = [
    ./taz
    ./volt
    ./testvm
    ./vivobook
  ];
  importHosts = host: import host;
  hosts = builtins.map importHosts files;
in
  hosts

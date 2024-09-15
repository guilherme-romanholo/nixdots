{pkgs}:
pkgs.writeShellScriptBin "rebuild" ''

  if [ "$1" = "help" ]; then
    echo "Usage: rebuild [ switch/boot ] [ all/system/home ]"
    echo "Note: home only have switch option"
    exit 0
  fi

  if [ "$2" = "all" ]; then
    sudo nixos-rebuild $1 --flake ~/.dotfiles
    ${pkgs.home-manager}/bin/home-manager switch --flake ~/.dotfiles
  elif [ "$2" = "system" ]; then
    sudo nixos-rebuild $1 --flake ~/.dotfiles
  elif [ "$2" = "home" ]; then
    ${pkgs.home-manager}/bin/home-manager switch --flake ~/.dotfiles
  else
    exit 1
  fi
''

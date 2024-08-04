{pkgs}:
pkgs.writeShellScriptBin "theme-switch" ''
  color_path=~/.dotfiles/themes
  RED='\033[0;31m'

  if [ "$1" = "help" ]; then
    echo "Usage: theme-switch [theme]"
    echo "Note: Restart system to apply the changes correctly."
    \ls $color_path -I default.nix
    exit 0
  fi

  cd $color_path

  mv default.nix default.nix.temp
  ln -s $1/default.nix default.nix

  sudo nixos-rebuild switch --flake ~/.dotfiles
  ${pkgs.home-manager}/bin/home-manager switch --flake ~/.dotfiles

  rm default.nix
  mv default.nix.temp default.nix

  echo -e "$RED Restart session to apply the changes correctly."
''

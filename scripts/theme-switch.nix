{pkgs}:
pkgs.writeShellScriptBin "theme-switch" ''
  color_path=~/.dotfiles/themes
  RED='\033[0;31m'

  if [ "$1" = "help" ]; then
    echo "Usage: theme-switch [theme]"
    echo "Note: Restart system to apply the changes correctly."
    \ls $color_path -I default
    exit 0
  fi

  cd $color_path

  mv default default.temp
  ln -s $1 default

  sudo nixos-rebuild switch --flake ~/.dotfiles

  rm default
  mv default.temp default
''

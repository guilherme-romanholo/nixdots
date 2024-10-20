{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.fish;
in {
  options.modules.fish = {
    enable = lib.mkEnableOption "Fish";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bat
      devenv
      ripgrep
    ];

    programs.eza = {
      enable = true;
      icons = "auto";
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    home.sessionVariables.DIRENV_LOG_FORMAT = "";

    programs.fish = {
      enable = true;

      shellAliases = {
        dots = "z ~/.dotfiles";
        cat = "bat";
        vim = "nvim";
        gs = "git status";
      };

      interactiveShellInit = ''
        set fish_greeting
        set -g theme_powerline_fonts no
        set -g theme_nerd_fonts yes
      '';
    };
  };
}

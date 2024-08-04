{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.base.zsh;
in {
  options.base.zsh = {
    enable = lib.mkEnableOption "Enable Zsh";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      bat
      devenv
      ripgrep
    ];

    programs.eza = {
      enable = true;
      icons = true;
    };

    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    home.sessionVariables.DIRENV_LOG_FORMAT = "";

    programs.zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ./.;
          file = "p10k.zsh";
        }
      ];

      shellAliases = {
        dots = "z ~/.dotfiles";
        cat = "bat";
        cd = "z";
        vim = "nvim";
        gs = "git status";
      };
    };
  };
}

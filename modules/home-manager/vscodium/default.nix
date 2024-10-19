{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.modules.vscode;
in {
  options.modules.vscode = {
    enable = lib.mkEnableOption "Vscodium";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      clang-tools
    ];

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

      extensions = with pkgs.vscode-extensions;
        [
          llvm-vs-code-extensions.vscode-clangd
          ms-python.python
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "symbols";
            publisher = "miguelsolorio";
            version = "0.0.20";
            sha256 = "sha256-u5kwrPysf3Fn7Yn9hJg3aIq8XuK+cRtHJlvn9uGdB8U=";
          }
          {
            name = "vim";
            publisher = "vscodevim";
            version = "1.28.1";
            sha256 = "sha256-cr9gP3/3kB3X8PnhdBUdR0b2ydvqr5RhiFDIZ/6hlTM=";
          }
        ];

      keybindings = [
        {
          key = "ctrl+shift+t";
          command = "workbench.action.terminal.toggleTerminal";
        }
        {
          key = "ctrl+shift+e";
          command = "workbench.view.explorer";
        }
        {
          key = "ctrl+shift+q";
          command = "workbench.action.closeActiveEditor";
        }
      ];

      userSettings = {
        "window.zoomLevel" = 0.5;
        "workbench.iconTheme" = "symbols";
        "symbols.hidesExplorerArrows" = false;
        "editor.lineHeight" = 1.8;
        "editor.rulers" = [80 120];
        "editor.renderLineHighlight" = "gutter";
        "editor.fontLigatures" = true;
        "workbench.editor.labelFormat" = "short";
        "explorer.compactFolders" = false;
        "breadcrumbs.enabled" = false;
        "workbench.activityBar.location" = "hidden";
        "editor.minimap.enabled" = false;
        "editor.scrollbar.vertical" = "hidden";
        "editor.scrollbar.horizontal" = "hidden";
        "workbench.statusBar.visible" = false;
        "window.commandCenter" = false;
        "workbench.layoutControl.enabled" = false;
        "explorer.fileNesting.enabled" = true;
      };
    };
  };
}

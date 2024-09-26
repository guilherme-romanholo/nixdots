{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.apps.vscode;
in {
  options.apps.vscode = {
    enable = lib.mkEnableOption "Enable Vscode";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;

      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        ms-vscode.cpptools-extension-pack
        llvm-vs-code-extensions.vscode-clangd
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "apc-extension";
          publisher = "drcika";
          version = "0.4.1";
          sha256 = "sha256-fq2qlxc7+MpwkraVClB0FGsR0K1/2MTzQ0SYULMx4Kg=";
        }
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

      userSettings = {
        "window.zoomLevel" = 0.5;
        "workbench.iconTheme" = "symbols";
        "symbols.hidesExplorerArrows" = false;
        "editor.lineHeight" = 1.8;
        "editor.rulers" = [80 120];
        "workbench.startupEditor" = "newUntitledFile";
        "editor.renderLineHighlight" = "gutter";
        "editor.fontLigatures" = true;
        "workbench.editor.labelFormat" = "short";
        "explorer.compactFolders" = false;
        "breadcrumbs.enabled" = false;
        "workbench.activityBar.location" = "hidden";
        "editor.minimap.enabled" = false;
        "editor.scrollbar.vertical" = "hidden";
        "editor.scrollbar.horizontal" = "hidden";
        # "workbench.statusBar.visible" = false;
        "window.commandCenter" = false;
        "workbench.layoutControl.enabled" = false;
        "explorer.fileNesting.enabled" = true;
        "apc.electron" = {
          "titleBarStyle" = "hiddenInset";
          "opacity" = 0.5;
          "vibrancy" = "dark";
          "frame" = false;
        };
      };
    };
  };
}

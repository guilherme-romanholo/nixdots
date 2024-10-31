{
  imports = [
    ./settings.nix
    ./keys.nix

    # Mini
    ./plugins/mini

    # Lsp
    ./plugins/lsp/lsp.nix
    ./plugins/lsp/conform.nix
    ./plugins/lsp/lspsaga.nix

    # Git
    ./plugins/git/gitsigns.nix

    # Tree
    ./plugins/tree/neotree.nix
    ./plugins/tree/treesitter.nix

    # Completion
    ./plugins/completion/cmp.nix
    ./plugins/completion/lspkind.nix

    # Snippets
    ./plugins/snippets/luasnip.nix

    # Utils
    ./plugins/utils/harpoon.nix
    ./plugins/utils/whichkey.nix
    ./plugins/utils/floaterm.nix
    ./plugins/utils/autopairs.nix
    ./plugins/utils/guess-ident.nix
    ./plugins/utils/todo-comments.nix

    # UI
    ./plugins/ui/precognition.nix
    ./plugins/ui/bufferline.nix
    ./plugins/ui/toggleterm.nix
    ./plugins/ui/lualine.nix
    ./plugins/ui/noice.nix
    ./plugins/ui/alpha.nix
  ];
}

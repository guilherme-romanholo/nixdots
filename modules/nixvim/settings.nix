{
  colorschemes.base16 = {
    enable = true;
    setUpBar = false;
    colorscheme = import ./colors/gruvbox.nix {};
  };

  # clipboard.providers.wl-copy.enable = true;

  opts = {
    # Line numbers
    number = true;
    relativenumber = true;

    # Signcolumn
    signcolumn = "yes";

    # Tabs
    smartindent = true;
    shiftwidth = 2;

    # Text wrap
    wrap = true;
  };
}

{
  plugins.conform-nvim = {
    enable = true;

    settings = {
      format_on_save = {
        lspFallback = true;
        timeoutMs = 500;
      };

      notify_on_error = true;

      formatters_by_ft = {
        python = ["black"];
        nix = ["alejandra"];
      };
    };
  };
}

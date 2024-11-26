{
  lib,
  config,
  ...
}: let
  cfg = config.optional.grafana;
in {
  options.optional.grafana = {
    enable = lib.mkEnableOption "Enable Grafana";
  };

  config = lib.mkIf cfg.enable {
    services.grafana = {
      enable = true;
      settings = {
        server = {
          http_addr = "127.0.0.1";
          http_port = 3000;

          domain = "localhost";
          root_url = "https://localhost/grafana/";
          serve_from_sub_path = true;
        };
      };
    };
  };
}

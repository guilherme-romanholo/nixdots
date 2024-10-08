{
  lib,
  config,
  ...
}: let
  cfg = config.desktop.nwg-dock;
in {
  options.desktop.nwg-dock = {
    enable = lib.mkEnableOption "Enable Nwg Dock";
  };

  config = lib.mkIf cfg.enable {
    home.file.".config/nwg-dock/hotspot.css".text = ''
      window {
        background-color: rgba (0, 0, 0, 0);
        border: none
      }
    '';

    home.file.".config/nwg-dock/style.css".text = ''
      window {
        /*background-color: rgba (0, 0, 0, 0.8);*/
        background: #36364f;
        /*opacity: 0.9;*/
  	    border-radius: 15px;
  	    border-style: none;
  	    border-width: 1px;
  	    border-color: rgba (156, 142, 122, 0.7)
      }
  
      #box {
        /* Define attributes of the box surrounding icons here */
        padding: 10px
      }
      
      button, image {
      	background: none;
      	border-style: none;
      	box-shadow: none;
      	color: #999
      }
      
      button {
      	/*padding-left: 4px;
      	padding-right: 4px;*/
      	padding: 4px;
      	margin-left: 4px;
      	margin-right: 4px;
      	color: #eee;
        font-size: 12px
      }
      
      button:hover {
      	background-color: rgba (255, 255, 255, 0.15);
      	border-radius: 2px;
      }
      
      button:focus {
      	box-shadow: 0 0 2px;
      }
    '';
  };
}

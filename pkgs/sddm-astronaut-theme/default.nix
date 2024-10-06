{pkgs}: let
  image = ./1.png;
in 
  pkgs.stdenv.mkDerivation {
    name = "sddm-astronaut-theme";
  
    src = pkgs.fetchFromGitHub {
      owner = "Keyitdev";
      repo = "sddm-astronaut-theme";
      rev = "44fb2ff2281933fee49405b77e1a27214e61f45c";
      sha256 = "sha256-vCXB5tOFcJSwJWvcLFDrJpL/N2A7UGlbtPsHOwBNOMY=";
    };
  
    dontWrapQtApps = true;
    propagatedBuildInputs = with pkgs.kdePackages; [qt5compat qtsvg];
  
    installPhase = ''
      mkdir -p $out
      cp -R ./* $out/
      rm $out/Backgrounds/1.png
      cp -r ${image} $out/Backgrounds/1.png
      sed -i 's/FullBlur=""/FullBlur=true/' $out/Themes/theme1.conf
      sed -i 's/Blur=""/Blur=0.7/' $out/Themes/theme1.conf
      sed -i 's/HighlightColor="#343746"/HighlightColor="#ffffff"/' $out/Themes/theme1.conf
    '';
  }

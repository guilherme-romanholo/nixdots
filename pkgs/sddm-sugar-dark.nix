{pkgs}: let
  image = ../themes/gruvbox/gruv_mountain.png;
in
  pkgs.stdenv.mkDerivation {
    name = "sddm-sugar-dark";

    src = pkgs.fetchFromGitHub {
      owner = "MarianArlt";
      repo = "sddm-sugar-dark";
      rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
      sha256 = "sha256-flOspjpYezPvGZ6b4R/Mr18N7N3JdytCSwwu6mf4owQ=";
    };

    installPhase = ''
      mkdir -p $out
      cp -R ./* $out/
      rm $out/Background.jpg
      cp -r ${image} $out/Background.jpg
      sed -i 's/ForceHideCompletePassword=false/ForceHideCompletePassword=true/' $out/theme.conf
    '';
  }

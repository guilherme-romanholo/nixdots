{pkgs}:
pkgs.stdenv.mkDerivation {
  name = "gruvbox-icons-plus";

  src = pkgs.fetchFromGitHub {
    owner = "SylEleuth";
    repo = "gruvbox-plus-icon-pack";
    rev = "e7145b531787e93b300f0419ffb1b4c00b4124cf";
    sha256 = "7bNdoXk+mhNe4Si3zkTbLkqA+NxeTh7YOspFlT1A47o=";
  };

  installPhase = ''
    mkdir -p $out
    mkdir -p $out/share/icons
    cp -R ./Gruvbox-Plus-Dark $out/share/icons
  '';
}

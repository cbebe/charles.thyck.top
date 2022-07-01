{ pkgs ? import <nixpkgs> {} }:
let resumeTex = (pkgs.texlive.combine {
  inherit (pkgs.texlive) scheme-basic
    # Just the necessary packages to compile my Resume
    marvosym
    metafont
    preprint
    enumitem
    fancyhdr
    titlesec;
});
in
pkgs.mkShell {
  nativeBuildInputs = [ resumeTex pkgs.entr pkgs.zathura ];
  # Don't litter on the user's home directory
  shellHook = ''
    export TEXMFHOME=/tmp/resume/texmf
    export TEXMFVAR=/tmp/resume/texlive/texmf-var
    export TEXMFCONFIG=/tmp/resume/texlive/texmf-config
  '';
}

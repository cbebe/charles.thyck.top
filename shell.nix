{ pkgs ? import <nixpkgs> {} }:
let tex = (pkgs.texlive.combine {
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
pkgs.mkShell { nativeBuildInputs = [ tex pkgs.entr pkgs.zathura ]; }

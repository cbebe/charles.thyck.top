{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [ gnumake ocaml ninja patchelf ];
  shellHook = ''
    pnpm install
    patchelf  --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" node_modules/gentype/gentype.exe
  '';
}

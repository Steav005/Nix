{ config, pkgs, ... }:
# Rust
#dustypomerleau.rust-syntax
#rust-lang.rust
#TabNine.tabnine-vscode
#serayuzgur.crates
{
  environment.systemPackages = with pkgs; [
    gitAndTools.gitFull
    gnumake
    llvm
    nix-index
    nix-review
    nixfmt
    nixdoc
    perf-tools
    glibc
    glib
    pkgconfig
  ];
}

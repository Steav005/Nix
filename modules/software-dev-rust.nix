{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    #cargo
    #rustc
    cargo-asm
    cargo-bloat
    cargo-expand
    cargo-flamegraph
    cargo-generate
    cargo-release
    cargo-tarpaulin
    cargo-watch
  ];
}

{ config, pkgs, ... }:

{
  imports = [ ./dev-c.nix ];

  environment.systemPackages = with pkgs; [
    #cargo
    #rustc
    rustup
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

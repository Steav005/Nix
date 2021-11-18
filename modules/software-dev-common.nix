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
    perf-tools
    glibc
    glib
    pkgconfig
    pkgs.emacsGcc # Installs Emacs 28 + native-comp

    # Jetbrains
    jetbrains.rider
    jetbrains.clion
    jetbrains.webstorm
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional

    (vscode-with-extensions.override {
      vscodeExtensions = (with pkgs.vscode-extensions; [
        ms-python.python
        ms-azuretools.vscode-docker

        bbenoist.nix
        jnoortheen.nix-ide
        matklad.rust-analyzer
        serayuzgur.crates
      ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
        name = "rust-syntax";
        publisher = "dustypomerleau";
        version = "0.6.0";
        sha256 = "sha256-dtSQgFLU61q9bboNIWNOfuFREQ6kEUMEeLVchrt625o=";
      }];
    })
  ];
}

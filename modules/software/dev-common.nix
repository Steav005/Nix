{ config, pkgs, ... }: {
  imports = [ ./dev-common-minimal.nix ];
  environment.systemPackages = with pkgs; [
    # Jetbrains
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional

    # Run github actions locally
    unstable.act

    (vscode-with-extensions.override {
      vscodeExtensions = (with pkgs.vscode-extensions; [
        ms-python.python
        ms-azuretools.vscode-docker

        #bbenoist.nix
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

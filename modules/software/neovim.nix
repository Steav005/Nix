{ config, pkgs, ... }:

{
  programs.neovim.enable = true;
  programs.neovim.viAlias = true;

  # Set Nvim as default
  environment.variables.EDITOR = "nvim";

  environment.systemPackages = with pkgs.unstable;
    [
      (neovim.override {
        withNodeJs = true;
        configure = {
          packages.myVimPackage = with vimPlugins; {
            # see examples below how to use custom packages
            start = [
              nvim-lspconfig
              skim

              table-mode

              vim-css-color
              vim-grammarous
              vim-nix
              vim-toml
            ];
            opt = [ goyo ];
          };
        };
      })
    ];
}

{ pkgs, ... }:

{
  imports = [ ../modules/software-neovim.nix ];
  environment.systemPackages = with pkgs; [
    bottom
    calc
    exa
    file
    htop
    neofetch
    fd
    bat
    wget
    cava
    skim
    ripgrep
    du-dust
    unstable.helvum

    # archivers & compression algos
    bzip2
    gzip
    lz4
    pigz
    pixz
    s-tar
    unzip
    xz
    zip
    zstd
  ];

}

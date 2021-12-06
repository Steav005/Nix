{ pkgs, ... }:

{
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
    hdparm

    # archivers & compression algos
    bzip2
    gzip
    lz4
    pigz
    pixz
    unzip
    xz
    zip
    zstd
  ];

}

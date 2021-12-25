{ pkgs, ... }: {
  services.xserver.screenSection = ''
    Option         "nvidiaXineramaInfoOrder" "DFP-5"
    Option         "metamodes" "DP-2: 1920x1080_240 +2560+0, DP-0: 2560x1440 +0+0"
  '';
}

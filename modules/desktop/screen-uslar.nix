{ pkgs, ... }: {
  services.xserver.screenSection = ''
    Option         "nvidiaXineramaInfoOrder" "DFP-5"
    Option         "metamodes" "DP-2: 1920x1080_240 +0+0, HDMI-1: 1280x1024 +1920+56"
  '';
}

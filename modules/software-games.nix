{ pkgs, inputs, info, ... }: {

  environment.systemPackages = with pkgs; [
    xow # XBox Wirless dongle support

    obs-studio # Streaming software

    lutris

    (retroarch.override {
      cores = [
        libretro.ppsspp
        unstable.libretro.dolphin
        libretro.mupen64plus
        libretro.parallel-n64
      ];
    })

    #(pkgs.makeDesktopItem rec {
    #  name = "ppsspp";
    #  exec = "ppsspp";
    #  desktopName = "PPSSPP";
    #  icon = "ppsspp";
    #})
  ];

  #Xow patch libusb
  #nixpkgs.config.packageOverrides = pkgs: {
  #  xow = pkgs.xow.overrideAttrs (orig: {
  #    buildInputs = [ inputs.my-flakes.packages."${info.arch}".libusb ];
  #  });
  #};

  # Steam
  programs.steam.enable = true;
}

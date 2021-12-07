{ pkgs, inputs, info, ... }: {

  environment.systemPackages = with pkgs; [
    xow # XBox Wirless dongle support

    lutris
    steam-run-native

    (retroarch.override {
      cores = [
        libretro.ppsspp
        unstable.libretro.dolphin
        libretro.mupen64plus
        libretro.parallel-n64
        libretro.gambatte
        libretro.citra
        libretro.melonds
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
  nixpkgs.config.packageOverrides = pkgs: {
    xow = pkgs.xow.overrideAttrs (orig: {
      buildInputs = [ inputs.my-flakes.packages."${info.arch}".libusb ];
    });
  };
  services.xserver.modules = [ pkgs.xlibs.xf86inputjoystick ];
  hardware.xpadneo.enable = true;

  # Steam
  programs.steam.enable = true;
  hardware.steam-hardware.enable = true;
}

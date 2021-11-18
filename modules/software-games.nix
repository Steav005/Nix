{ pkgs, inputs, ... }: {

  environment.systemPackages = with pkgs; [
    xow # XBox Wirless dongle support
    ppsspp # PSP Emulator
    dolphinEmu # Wii Emulator

    obs-studio # Streaming software

    (pkgs.makeDesktopItem rec {
      name = "ppsspp";
      exec = "ppsspp";
      desktopName = "PPSSPP";
      icon = "ppsspp";
    })
  ];

  #Xow patch libusb
  nixpkgs.config.packageOverrides = pkgs: {
    xow = pkgs.xow.overrideAttrs (orig: {
      version = "pre-1.0.25";
      buildInputs = [ inputs.my-flakes.packages.x86_64-linux.libusb ];
    });
  };

  # Steam
  programs.steam.enable = true;
}

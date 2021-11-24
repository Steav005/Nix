{ config, lib, pkgs, modulesPath, inputs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    #./hardware-configuration.nix
    ../common.nix
    ../modules/desktop/common.nix
    ../modules/desktop/gnome.nix
    ../modules/fish.nix
    ../users/autumnal.nix
    ../modules/software-common.nix
    ../modules/nix-flakes.nix
    ../modules/software-dev-common.nix
    ../modules/software-dev-c.nix
    ../modules/software-dev-python.nix
    ../modules/software-dev-rust.nix
    ../modules/software-games.nix
    ../modules/software-neovim.nix
    ../modules/network-wifi.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # Graphics
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
  #hardware.nvidia.package = pkgs.unstable.linuxKernel.packages.linux_zen.nvidia_x11;
  hardware.nvidia.modesetting.enable = true;
  services.xserver = {
    #  videoDrivers = [ "nvidia" ];
    dpi = 160;
  };
  #hardware.nvidia.prime = {
  #  sync.enable = true;
  #  intelBusId = "PCI:0:2:0";
  #  nvidiaBusId = "PCI:1:0:0";
  #};

  networking.hostName = "last-order"; # Define your hostname.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlo1.useDHCP = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  ### HARDWARE CONFIGURATION

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  #boot.extraModulePackages = [ config.boot.kernelPackages.nvidiaPackages.stable ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5cabec94-b823-4032-aed1-2677c7c87bd5";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/705E-7CED";
    fsType = "vfat";
  };

  fileSystems."/net/index" = {
    device = "index:/media";
    fsType = "nfs";
    noCheck = true;
    options = [
      "noauto"
      "_netdev"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=4s"
      "x-systemd.mount-timeout=4s"
    ];
  };

  fileSystems."/net/tenshi" = {
    device = "tenshi:/";
    fsType = "nfs";
    options = [
      "noauto"
      "_netdev"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=4s"
      "x-systemd.mount-timeout=4s"
    ];
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/0cd9369b-0299-4272-ae5c-e61d78ca5164"; }];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}


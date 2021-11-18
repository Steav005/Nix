{ config, pkgs, modulesPath, overlay-unstable, inputs, ... }: {

  system.stateVersion = "21.05";

  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")

    ./modules/desktop-common.nix
    ./modules/desktop-i3.nix
    ./modules/fish.nix
    ./modules/nix-flakes.nix
    ./modules/service-zerotier.nix
    ./modules/service-openssh.nix
    ./modules/software-common.nix
    ./modules/software-dev-c.nix
    ./modules/software-dev-common.nix
    ./modules/software-dev-python.nix
    ./modules/software-dev-rust.nix
    ./modules/software-games.nix
    ./modules/user-autumnal.nix
    ./modules/virtualisation-docker.nix
  ];

  boot.kernelPackages = pkgs.lib.mkDefault pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.nvidiaPackages.beta ];
  boot.kernelParams = [
    # https://help.ubuntu.com/community/AppleKeyboard
    # https://wiki.archlinux.org/index.php/Apple_Keyboard
    "hid_apple.fnmode=1"
    "hid_apple.iso_layout=0"
    "hid_apple.swap_opt_cmd=1"
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/20f9164f-4751-4480-b385-13d2771398ba";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A913-2C95";
    fsType = "vfat";
  };

  swapDevices = [ ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "neesama";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time = {
    timeZone = "Europe/Berlin";
    hardwareClockInLocalTime = true;
  };

  # Virtualisation
  virtualisation.libvirtd.enable = true;

  # DHCP
  networking.useDHCP = false;
  networking.interfaces.enp5s0.useDHCP = true;
  networking.interfaces.wlp6s0.useDHCP = true;

  environment.pathsToLink =
    [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw

  location = {
    provider = "manual";
    latitude = 51.8;
    longitude = 10.3;
  };

  # Graphics
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # Set display for neesama
  services.xserver = {
    # Handles with autorandr
    #screenSection = ''
    #  # Option "metamodes" "DP-2: nvidia-auto-select +2560+180, DP-0: 2560x1440 +0+0"
    #  Option "metamodes" "DP-0: nvidia-auto-select +0+0, HDMI-0: 1280x1024 +1920+204"
    #'';
    videoDrivers = [ "nvidia" ];

    # Set DPI
    dpi = 82;
  };
  nixpkgs.config.allowUnfree = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  # Mount
  boot.supportedFilesystems = [ "ntfs" ];
  # SSD Storage
  fileSystems."/mnt/ssddata" = {
    device = "/dev/disk/by-uuid/08D24544D245376A";
    fsType = "ntfs";
    options = [ "rw" "uid=1000" "nofail" ];
  };
  # Manjaro Drive
  fileSystems."/mnt/manjaro" = {
    device = "/dev/disk/by-uuid/cb1828bd-79db-4fa4-834e-f49c754f94cd";
    fsType = "ext4";
    options = [ "rw" "nofail" ];
  };
}


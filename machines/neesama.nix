# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ../common.nix
    #../modules/desktop/gnome.nix
    #../modules/desktop/leftwm.nix
    ../modules/desktop/i3.nix
    ../modules/fish.nix
    ../modules/nix-flakes.nix
    ../modules/software/common.nix
    ../modules/software/dev-common.nix
    ../modules/software/dev-python.nix
    ../modules/software/dev-rust.nix
    ../modules/software/games.nix
    ../modules/software/neovim.nix
    ../modules/virtualisation-docker.nix
    ../users/autumnal.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #boot.kernelPackages = pkgs.unstable.linuxPackages_xanmod;
  boot.kernelPackages = pkgs.unstable.linuxPackages_zen;

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  #hardware.nvidia.package =
  #  pkgs.unstable.linuxKernel.packages.linux_xanmod.nvidia_x11_beta;
  hardware.nvidia.package =
    pkgs.unstable.linuxKernel.packages.linux_zen.nvidia_x11_beta;
  services.xserver.videoDrivers = [ "nvidia" ];

  networking.hostName = "neesama";

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [
    # https://help.ubuntu.com/community/AppleKeyboard
    # https://wiki.archlinux.org/index.php/Apple_Keyboard
    "hid_apple.fnmode=1"
    "hid_apple.iso_layout=0"
    "hid_apple.swap_opt_cmd=1"
  ];

  # Pipewire sometimes doesn't work with usb audio devices
  # Increase Headroom
  services.pipewire.media-session.config.alsa-monitor.rules = [
    {
      "actions"."update-props" = {
        "api.acp.auto-port" = false;
        "api.acp.auto-profile" = false;
        "api.alsa.use-acp" = true;
      };
      "matches" = [{ "device-name" = "~alsa_card.*"; }];
    }
    {
      "actions"."update-props" = {
        "node.pause-on-idle" = false;
        "api.alsa.period-size" = 256;
        "api.alsa.headroom" = 1024;
      };
      "matches" = [
        { "node.name" = "~alsa_input.*"; }
        { "node.name" = "~alsa_output.*"; }
      ];
    }
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/52ebffd7-c8dd-48f0-a9d1-88c01be0da4f";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/994C-6ECB";
    fsType = "vfat";
  };

  fileSystems."/media/artix" = {
    device = "/dev/disk/by-uuid/9f73350b-3d9b-4b27-a7b8-1405384db490";
    fsType = "btrfs";
  };

  fileSystems."/media/ssddata" = {
    device = "/dev/disk/by-uuid/81c6fec5-b8e1-4d7a-b68e-39b16dcc2f86";
    fsType = "btrfs";
  };

  fileSystems."/net/index" = {
    device = "index:/export/media";
    fsType = "nfs";
    noCheck = true;
    options = [
      "noauto"
      "_netdev"
      "x-systemd.automount"
      #"x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=4s"
      "x-systemd.mount-timeout=4s"
    ];
  };

  swapDevices = [ ];

}

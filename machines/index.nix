{ config, lib, pkgs, modulesPath, inputs, ... }: {
  imports = [
    ../common.nix
    ../modules/fish.nix
    ../users/autumnal.nix
    ../modules/nix-flakes.nix
    #../modules/software-common.nix
    #../modules/software-neovim.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # NixOS wants to enable GRUB by default
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_rpi4;
  boot.initrd.availableKernelModules = [ "usbhid" "usb_storage" "vc4" ];

  networking = {
    hostName = "index";
    interfaces.eth0.ipv4.addresses = [{
      address = "192.168.178.2";
      prefixLength = 24;
    }];
    defaultGateway = "192.168.178.1";
    nameservers = [ "1.1.1.1" ];
  };

  powerManagement.cpuFreqGovernor = "ondemand";

  # File systems configuration for using the installer's partition layout
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  system.stateVersion = "21.05";
}

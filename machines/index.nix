{ config, lib, pkgs, modulesPath, inputs, ... }: {
  imports = [
    ../common.nix
    ../modules/fish.nix
    ../modules/nix-flakes.nix
    ../modules/adguard.nix
    ../modules/software/common.nix
    ../modules/software/dev-common-minimal.nix
    #../modules/software/neovim.nix
    ../modules/virtualisation-docker.nix
    ../users/autumnal.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # NixOS wants to enable GRUB by default
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_rpi4;
  boot.initrd.availableKernelModules = [ "usbhid" "usb_storage" "vc4" ];

  environment.systemPackages = with pkgs; [ libraspberrypi ];

  networking = {
    hostName = "index";
    interfaces.eth0.ipv4.addresses = [{
      address = "192.168.178.2";
      prefixLength = 24;
    }];
    defaultGateway = "192.168.178.1";
    nameservers = [ "1.1.1.1" ];
  };

  networking.firewall.allowedTCPPorts = [
    53 # adguardhome dns
    3000 # Adguardhome admin
    139 # Samba
    445 # Samba
    2049 # NFS Server
    6767 # Bazarr
    7878 # Radarr
    8080 # Scrunity
    8989 # Sonarr
    9000 # Portainer
    9091 # Transmission
    9117 # Jackett
    32400 # Plex
  ];

  networking.firewall.allowedUDPPorts = [
    53 # adguardhome dns
    137 # Samba
    138 # Samba
  ];

  # Join share network
  services.zerotierone.joinNetworks = [
    "12ac4a1e711ec1f6" # Weebwork
  ];

  # Limit Bandwidth for weebwork network
  networking.firewall = {
    extraPackages = with pkgs; [ iproute ];
    extraCommands = ''
      # Limit WeebWork upload to 24mbits with 1024kbit bursts. Drop packages with more than 800ms latency
      # https://netbeez.net/blog/how-to-use-the-linux-traffic-control/
      tc qdisc add dev ztbtovjx4h root tbf rate 24mbit burst 1024kbit latency 800ms
    '';
  };

  # File systems configuration for using the installer's partition layout
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
    "/media" = {
      device = "/dev/disk/by-label/storage";
      fsType = "btrfs";
      options = [ "noatime" ];
    };
  };

  # Mount for nfs export
  fileSystems = {
    "/export/media" = {
      device = "/media";
      options = [ "bind" ];
    };
    "/export/anime" = {
      device = "/media/torrent_storage/anime";
      options = [ "bind" ];
    };
    "/export/movies" = {
      device = "/media/torrent_storage/movies";
      options = [ "bind" ];
    };
  };

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /export/media 10.0.0.0/13(rw,no_all_squash)
    /export/anime 192.168.194.0/24(ro,all_squash,subtree_check)
    /export/movies 192.168.194.0/24(ro,all_squash,subtree_check)
  '';

  services.samba = {
    enable = true;
    nsswins = true;
    extraConfig = ''
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      anime = {
        browseable = "yes";
        comment = "Anime Share";
        path = "/media/torrent_storage/anime";
        "guest ok" = "yes";
        "read only" = "yes";
      };
      movies = {
        browseable = "yes";
        comment = "Movie Share";
        path = "/media/torrent_storage/movies";
        "guest ok" = "yes";
        "read only" = "yes";
      };
    };
  };

  powerManagement.cpuFreqGovernor = "ondemand";

  system.stateVersion = "21.05";
}

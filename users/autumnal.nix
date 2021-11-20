{ config, pkgs, ... }: {

  users.users.autumnal = {
    isNormalUser = true;
    extraGroups = [ "wheel" "disk" "audio" "video" "networkmanager" "docker" ];
    shell = pkgs.fish;
    home = "/home/autumnal";
    description = "Sven Friedrich";
    hashedPassword =
      "$6$C2lvYMnUwU$fHgjzsQRizvJclKHgscbXiPjrFp0Zm5jvC7Qi1wBdn6poFZ.qDpqmqmuW2UcrT9G.sccZ1W6Htx4Qszf0id68/";
    openssh.authorizedKeys.keys = [

    ];
  };

  home-manager.users.autumnal = import ./autumnal/home.nix;
}
